{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                         							}
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.SOAPDm;

interface

uses
  {$IFDEF MSWINDOWS}Winapi.Windows, System.Win.ComObj,{$ENDIF}
  System.Generics.Collections,
  System.Classes,
  Datasnap.Midas, Datasnap.Provider,
  System.SysUtils,
  Web.HTTPApp,
  Soap.SOAPMidas,
  System.Types, System.SyncObjs;

{$HPPEMIT ''}
{$HPPEMIT '/* Automatically link to SOAPMidas where IAppServer is registered */'}
{$IFDEF WIN32}
{$HPPEMIT '#pragma link "Soap.SOAPMidas.obj"'}
{$ENDIF}
{$IFDEF POSIX}
{$HPPEMIT '#pragma link "Soap.SOAPMidas.o"'}
{$ENDIF}
{$HPPEMIT ''}

type
  { TSoapDataModule}
  TSoapDataModule = class(TDataModule, IAppServer, IAppServerSOAP, IProviderContainer)
  private
    FProviders: TList<TCustomProvider>;
    FCriticalSection: TCriticalSection;
    FRefCount: Integer;

    function GetProviderCount: integer;
  protected
    function GetProvider(const ProviderName: string): TCustomProvider; virtual;
    { Internal implementation for IAppServer and IAppServerSOAP }
    function GetProviderNames: OleVariant;
    function ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                          MaxErrors: Integer; out ErrorCount: Integer;
                          var OwnerData: OleVariant): OleVariant;
    function  GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                         Options: Integer; const CommandText: OleStr;
                         var Params: OleVariant; var OwnerData: OleVariant): OleVariant;
    function DataRequest(const ProviderName: OleStr;
                         Data: OleVariant): OleVariant;
    function GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant;
    function RowRequest(const ProviderName: OleStr; Row: OleVariant;
                        RequestType: Integer; var OwnerData: OleVariant): OleVariant;
    procedure Execute(const ProviderName: OleStr;
                      const CommandText: OleStr; var Params, OwnerData: OleVariant);
    { IAppServer }
    function AS_GetProviderNames: OleVariant; safecall;
    function AS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                             MaxErrors: Integer; out ErrorCount: Integer;
                             var OwnerData: OleVariant): OleVariant; safecall;
    function  AS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                            Options: Integer; const CommandText: OleStr;
                            var Params: OleVariant; var OwnerData: OleVariant): OleVariant; safecall;
    function AS_DataRequest(const ProviderName: OleStr;
                            Data: OleVariant): OleVariant; safecall;
    function AS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant; safecall;
    function AS_RowRequest(const ProviderName: OleStr; Row: OleVariant;
                           RequestType: Integer; var OwnerData: OleVariant): OleVariant; safecall;
    procedure AS_Execute(const ProviderName: OleStr;
                         const CommandText: OleStr; var Params, OwnerData: OleVariant); safecall;
    { IAppServerSOAP }
    function  SAS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                              MaxErrors: Integer; out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; virtual; stdcall;
    function  SAS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                             Options: Integer; const CommandText: OleStr;
                             var Params: OleVariant; var OwnerData: OleVariant): OleVariant; virtual; stdcall;
    function  SAS_DataRequest(const ProviderName: OleStr; Data: OleVariant): OleVariant; virtual; stdcall;
{$IFDEF NEXTGEN}
    function  SAS_GetProviderNames: TStringDynArray; virtual; stdcall;
{$ELSE !NEXTGEN}
    function  SAS_GetProviderNames: TWideStringDynArray; virtual; stdcall;
{$ENDIF NEXTGEN}
    function  SAS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant; virtual; stdcall;
    function  SAS_RowRequest(const ProviderName: OleStr; Row: OleVariant; RequestType: Integer;
                             var OwnerData: OleVariant): OleVariant; virtual; stdcall;
    procedure SAS_Execute(const ProviderName: OleStr; const CommandText: OleStr;
                          var Params: OleVariant; var OwnerData: OleVariant); virtual; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    procedure Lock; virtual;
    procedure Unlock; virtual;
    { IProviderContainer }
    procedure RegisterProvider(Value: TCustomProvider);
    procedure UnRegisterProvider(Value: TCustomProvider);
    property Providers[const ProviderName: string]: TCustomProvider read GetProvider;
    property ProviderCount: integer read GetProviderCount;
    property RefCount: Integer read FRefCount;
    { Safecall Error Handling }
    function SafeCallException(ExceptObject: TObject;
                               ExceptAddr: Pointer): HResult; override;
  end;

implementation

uses
  System.Variants,
  Datasnap.MidConst;

{ TSoapDataModule }

constructor TSoapDataModule.Create(AOwner: TComponent);
begin
  FCriticalSection := TCriticalSection.Create;
  FProviders := TList<TCustomProvider>.Create;
  inherited Create(AOwner);
end;

destructor TSoapDataModule.Destroy;
begin
  inherited Destroy;
  FProviders.Free;
  FreeAndNil(FCriticalSection);
end;

procedure TSoapDataModule.Lock;
begin
  FCriticalSection.Enter;
end;

procedure TSoapDataModule.Unlock;
begin
  FCriticalSection.Leave;
end;

procedure TSoapDataModule.RegisterProvider(Value: TCustomProvider);
begin
  FProviders.Add(Value);
end;

procedure TSoapDataModule.UnRegisterProvider(Value: TCustomProvider);
begin
  FProviders.Remove(Value);
end;

function TSoapDataModule.GetProvider(const ProviderName: string): TCustomProvider;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FProviders.Count - 1 do
    if AnsiCompareStr(TCustomProvider(FProviders[i]).Name, ProviderName) = 0 then
    begin
      Result := TCustomProvider(FProviders[i]);
      if not Result.Exported then
        Result := nil;
      Break;
    end;
  if not Assigned(Result) then
    raise Exception.CreateResFmt(@SProviderNotExported, [ProviderName]);
end;

{ Internal Implementation }

function TSoapDataModule.GetProviderNames: OleVariant;
var
  List: TStringList;
  i: Integer;
begin
  Lock;
  try
    List := TStringList.Create;
    try
      for i := 0 to FProviders.Count - 1 do
        if TCustomProvider(FProviders[i]).Exported then
          List.Add(TCustomProvider(FProviders[i]).Name);
      List.Sort;
    Result := VarArrayFromStrings(List);
    finally
      List.Free;
    end;
  finally
    Unlock;
  end;
end;

function TSoapDataModule.ApplyUpdates(const ProviderName: OleStr;
  Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer;
  var OwnerData: OleVariant): OleVariant;
begin
  Lock;
  try
    Result := Providers[ProviderName].ApplyUpdates(Delta, MaxErrors, ErrorCount, OwnerData);
  finally
    Unlock;
  end;
end;

function  TSoapDataModule.GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                            Options: Integer; const CommandText: OleStr;
                            var Params: OleVariant; var OwnerData: OleVariant): OleVariant; 
begin
  Lock;
  try
    Result := Providers[ProviderName].GetRecords(Count, RecsOut, Options, CommandText, Params, OwnerData);
  finally
    Unlock;
  end;
end;

function TSoapDataModule.RowRequest(const ProviderName: OleStr;
  Row: OleVariant; RequestType: Integer; var OwnerData: OleVariant): OleVariant;
begin
  Lock;
  try
    Result := Providers[ProviderName].RowRequest(Row, RequestType, OwnerData);
  finally
    Unlock;
  end;
end;

function TSoapDataModule.DataRequest(const ProviderName: OleStr;
  Data: OleVariant): OleVariant; 
begin
  Lock;
  try
    Result := Providers[ProviderName].DataRequest(Data);
  finally
    Unlock;
  end;
end;

function TSoapDataModule.GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant;
begin
  Lock;
  try
    Result := Providers[ProviderName].GetParams(OwnerData);
  finally
    Unlock;
  end;
end;

procedure TSoapDataModule.Execute(const ProviderName: OleStr;
  const CommandText: OleStr; var Params, OwnerData: OleVariant);
begin
  Lock;
  try
    Providers[ProviderName].Execute(CommandText, Params, OwnerData);
  finally
    Unlock;
  end;
end;

{ IAppServer Implementation }

function TSoapDataModule.AS_GetProviderNames: OleVariant;
begin
  Result := GetProviderNames;
end;

function TSoapDataModule.AS_ApplyUpdates(const ProviderName: OleStr;
  Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer;
  var OwnerData: OleVariant): OleVariant;
begin
  Result := ApplyUpdates(ProviderName, Delta, MaxErrors, ErrorCount, OwnerData);
end;

function  TSoapDataModule.AS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                            Options: Integer; const CommandText: OleStr;
                            var Params: OleVariant; var OwnerData: OleVariant): OleVariant; safecall;
begin
  Result := GetRecords(ProviderName, Count, RecsOut, Options, CommandText, Params, OwnerData);
end;

function TSoapDataModule.AS_RowRequest(const ProviderName: OleStr;
  Row: OleVariant; RequestType: Integer; var OwnerData: OleVariant): OleVariant;
begin
  Result := RowRequest(ProviderName, Row, RequestType, OwnerData);
end;

function TSoapDataModule.AS_DataRequest(const ProviderName: OleStr;
  Data: OleVariant): OleVariant; safecall;
begin
  Result := DataRequest(ProviderName, Data);
end;

function TSoapDataModule.AS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant;
begin
  Result := GetParams(ProviderName, OwnerData);
end;

procedure TSoapDataModule.AS_Execute(const ProviderName: OleStr;
  const CommandText: OleStr; var Params, OwnerData: OleVariant);
begin
  Execute(ProviderName, CommandText, Params, OwnerData);
end;

function TSoapDataModule.GetProviderCount: integer;
begin
  Result := FProviders.Count;
end;

{ IAppServerSoap Implementation }

function  TSoapDataModule.SAS_ApplyUpdates(const ProviderName: OleStr; Delta: OleVariant;
                          MaxErrors: Integer; out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; stdcall;
begin
  Result := ApplyUpdates(ProviderName, Delta, MaxErrors, ErrorCount, OwnerData);
end;

function  TSoapDataModule.SAS_GetRecords(const ProviderName: OleStr; Count: Integer; out RecsOut: Integer;
                        Options: Integer; const CommandText: OleStr;
                        var Params: OleVariant; var OwnerData: OleVariant): OleVariant; stdcall;
begin
  Result := GetRecords(ProviderName, Count, RecsOut, Options, CommandText, Params, OwnerData);
end;

function  TSoapDataModule.SAS_DataRequest(const ProviderName: OleStr; Data: OleVariant): OleVariant; stdcall;
begin
  Result := DataRequest(ProviderName, Data);
end;

{$IFDEF NEXTGEN}
function  TSoapDataModule.SAS_GetProviderNames: TStringDynArray; stdcall;
{$ELSE !NEXTGEN}
function  TSoapDataModule.SAS_GetProviderNames: TWideStringDynArray; stdcall;
{$ENDIF NEXTGEN}
var
  V: OleVariant;
  I, Len: Integer;
begin
  V := GetProviderNames;
  if not VarIsNull(V) and VarIsArray(V) then
  begin
    for I := 0 to VarArrayHighBound(V, 1) do
    begin
      Len := Length(Result);
      SetLength(Result, Len+1);
      Result[Len] := V[I];
    end;
  end;
end;

function  TSoapDataModule.SAS_GetParams(const ProviderName: OleStr; var OwnerData: OleVariant): OleVariant; stdcall;
begin
  Result := GetParams(ProviderName, OwnerData);
end;

function  TSoapDataModule.SAS_RowRequest(const ProviderName: OleStr; Row: OleVariant; RequestType: Integer;
                        var OwnerData: OleVariant): OleVariant; stdcall;
begin
  Result := RowRequest(ProviderName, Row, RequestType, OwnerData);
end;

procedure TSoapDataModule.SAS_Execute(const ProviderName: OleStr; const CommandText: OleStr;
                     var Params: OleVariant; var OwnerData: OleVariant); stdcall;
begin
  Execute(ProviderName, CommandText, Params, OwnerData);
end;

procedure TSoapDataModule.AfterConstruction;
begin
  inherited;
  TInterlocked.Decrement(FRefCount);
end;

procedure TSoapDataModule.BeforeDestruction;
begin
  inherited;
end;

function TSoapDataModule._AddRef: Integer;
begin
  Result := TInterlocked.Increment(FRefCount);
end;

function TSoapDataModule._Release: Integer;
begin
  Result := TInterlocked.Decrement(FRefCount);
  { If we are not being used as a TComponent, then use refcount to manage our
    lifetime as with TInterfacedObject. }
  if (Result = 0) and (not Assigned(Owner)) then
    Destroy;
end;

{ Set an implicit refcount so that refcounting
  during construction won't destroy the object. }
class function TSoapDataModule.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TSoapDataModule(Result).FRefCount := 1;
end;

function TSoapDataModule.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HResult;
begin
{$IFDEF MSWINDOWS}
  Result := HandleSafeCallException(ExceptObject, ExceptAddr, IAppServer, '', '');
{$ELSE}
  if ExceptObject is Exception then
  begin
    SetSafeCallExceptionMsg(Exception(ExceptObject).Message);
    SetSafeCallExceptionAddr(ExceptAddr);
    Result := HResult($8000FFFF);
  end else
    Result := inherited SafeCallException(ExceptObject, ExceptAddr);
{$ENDIF}
end;




end.
