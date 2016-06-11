{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSProviderDataModuleAdapter;

interface

uses
  Data.DBXCommon, Datasnap.DataBkr, Datasnap.DSReflect, Datasnap.DSServer, System.Classes;

type

{ TDSProviderDataModuleAdapter }

  TDSProviderDataModuleAdapter = class(TDSDataModuleAdapterClass)
  private
    FProviderDataModule: TProviderDataModule;
  protected
    function ExtractDataModule: TDataModule; override;
  public
    constructor Create(AdapteeInstance: TObject); override;
    destructor Destroy; override;
    // IAppServerFastCall interface methods.
    //
    function  AS_ApplyUpdates(const ProviderName: WideString; DeltaStream: OleVariant;
      MaxErrors: Integer; out ErrorCount: Integer; OwnerDataStream: TDBXStreamValue): OleVariant;
    function  AS_GetRecords(const ProviderName: WideString; Count: Integer;
      out RecsOut: Integer; Options: Integer; const CommandText: WideString;
      ParamReader: TDBXStreamValue; OwnerDataStream: TDBXStreamValue): OleVariant;
    function  AS_DataRequest(const ProviderName: WideString;
      DataStream: OleVariant): OleVariant;
    function  AS_GetProviderNames: string;
    function  AS_GetParams(const ProviderName: WideString;
      OwnerDataStream: TDBXStreamValue): OleVariant;
    function  AS_RowRequest(const ProviderName: WideString; RowStream: OleVariant;
      RequestType: Integer; OwnerDataStream: TDBXStreamValue): OleVariant;
    procedure AS_Execute(const ProviderName, CommandText: WideString;
      ParamReader: TDBXStreamValue; OwnerDataStream: TDBXStreamValue);

      property ProviderDataModule: TProviderDataModule read FProviderDataModule write FProviderDataModule;
  end;

  TDSServerModuleBase = class(TProviderDataModule)
  public
    procedure BeforeDestruction; override;
    destructor Destroy; override;
  end;

  {$MethodInfo ON}
  TDSServerModule = class(TDSServerModuleBase)
  end;
  {$MethodInfo OFF}

  TDSProviderServerClassAdapter = class(TServerClassAdapter)
    function CreateInstance(const Instance: TObject): TObject; override;
    function IsSupportedAdapterType(const AObj: TObject): Boolean; override;
    function IsSupportedType(const AObj: TObject): Boolean; overload; override;
    function IsSupportedType(const AClass: TClass): Boolean; overload; override;
    function GetType: TPersistentClass; override;
    function GetDataModule(const AObj: TObject): TDataModule; override;
    procedure ClearDataModule(const AObj: TObject); override;
  end;

implementation

uses
  Data.DSUtil, Datasnap.DSServerResStrs, System.SysUtils, System.Variants;

{ TDSProviderDataModuleAdapter }

constructor TDSProviderDataModuleAdapter.Create(AdapteeInstance: TObject);
begin
  inherited Create(AdapteeInstance);
  FProviderDataModule := AdapteeInstance as TProviderDataModule;
end;

destructor TDSProviderDataModuleAdapter.Destroy;
begin
  FreeAndNil(FProviderDataModule);
  inherited;
end;

function TDSProviderDataModuleAdapter.ExtractDataModule: TDataModule;
begin
  Result := FProviderDataModule;
  FProviderDataModule := nil;
end;

function TDSProviderDataModuleAdapter.AS_ApplyUpdates(
  const ProviderName: WideString; DeltaStream: OleVariant; MaxErrors: Integer;
  out ErrorCount: Integer; OwnerDataStream: TDBXStreamValue): OleVariant;
var
  Delta: OleVariant;
  OwnerData: OleVariant;
begin
  // Setup input parameters
  OwnerData := OwnerDataStream.AsVariant;
  Delta := DeltaStream;
  Result := Unassigned;

  // Invoke the IAppServer method
  Result := FProviderDataModule.Providers[ProviderName].ApplyUpdates(
    Delta, MaxErrors, ErrorCount, OwnerData);

  // Assign output parameters
  OwnerDataStream.AsVariant := OwnerData;
end;

function TDSProviderDataModuleAdapter.AS_DataRequest(
  const ProviderName: WideString; DataStream: OleVariant): OleVariant;
begin
  // Invoke the IAppServer method
  Result := FProviderDataModule.Providers[ProviderName].DataRequest(DataStream);
end;

procedure TDSProviderDataModuleAdapter.AS_Execute(const ProviderName,
  CommandText: WideString; ParamReader: TDBXStreamValue; OwnerDataStream: TDBXStreamValue);
var
  Params: OleVariant;
  OwnerData: OleVariant;
begin
  // Setup input parameters
  Params := ParamReader.AsVariant;
  OwnerData := OwnerDataStream.AsVariant;

  // Invoke the IAppServer method
  FProviderDataModule.Providers[ProviderName].Execute(CommandText, Params, OwnerData);

  // Assign output parameters
  ParamReader.AsVariant := Params;
  OwnerDataStream.AsVariant := OwnerData;
end;

function TDSProviderDataModuleAdapter.AS_GetParams(const ProviderName: WideString;
  OwnerDataStream: TDBXStreamValue): OleVariant;
var
  Params: OleVariant;
  OwnerData: OleVariant;
begin
  // Setup input parameters
  OwnerData := OwnerDataStream.AsVariant;

  // Invoke the IAppServer method
  Params := FProviderDataModule.Providers[ProviderName].GetParams(OwnerData);

  // Assign output parameters
  Result := Params;
  OwnerDataStream.AsVariant := OwnerData;
end;

function TDSProviderDataModuleAdapter.AS_GetProviderNames: string;
var
  List: TStringList;
  Names: OleVariant;
begin
  // Invoke the IAppServer method
  Names := FProviderDataModule.ProviderNamesToVariant;

  // Convert the OleVariant list of names into a comma delimited string
  List := TStringList.Create;
  try
    List.StrictDelimiter := True;
    VarArrayToStrings(Names, List);
    Result := List.CommaText;
  finally
    List.Free;
  end;
end;

function TDSProviderDataModuleAdapter.AS_GetRecords(const ProviderName: WideString; Count: Integer;
      out RecsOut: Integer; Options: Integer; const CommandText: WideString;
      ParamReader: TDBXStreamValue; OwnerDataStream: TDBXStreamValue): OleVariant;
var
  Params: OleVariant;
  OwnerData: OleVariant;
begin
  // Setup input parameters
  Params := ParamReader.AsVariant;
  OwnerData := OwnerDataStream.AsVariant;
  Result := Null;

  // Invoke the IAppServer method
  Result := FProviderDataModule.Providers[ProviderName].GetRecords(
    Count, RecsOut, Options, CommandText, Params, OwnerData);

  // Assign output parameters
  ParamReader.AsVariant := Params;
  OwnerDataStream.AsVariant := OwnerData;
end;

function TDSProviderDataModuleAdapter.AS_RowRequest(
  const ProviderName: WideString; RowStream: OleVariant; RequestType: Integer;
  OwnerDataStream: TDBXStreamValue): OleVariant;
var
  Row: OleVariant;
  OwnerData: OleVariant;
begin
  // Setup input parameters
  Row := RowStream;
  OwnerData := OwnerDataStream.AsVariant;

  // Invoke the IAppServer method
  Result := FProviderDataModule.Providers[ProviderName]
  .RowRequest(Row, RequestType, OwnerData);

  // Assign output parameters
  OwnerDataStream.AsVariant := OwnerData;
end;

{ TDSServerModuleBase }

procedure TDSServerModuleBase.BeforeDestruction;
begin
  inherited;
end;

destructor TDSServerModuleBase.Destroy;
begin
  inherited;
end;

{ TDSProviderServerClassAdapter }

procedure TDSProviderServerClassAdapter.ClearDataModule(const AObj: TObject);
begin
  TDSProviderDataModuleAdapter(AObj).FProviderDataModule := nil;
end;

function TDSProviderServerClassAdapter.CreateInstance(const Instance: TObject): TObject;
begin
  Result := TDSProviderDataModuleAdapter.Create(Instance);
end;

function TDSProviderServerClassAdapter.GetDataModule(const AObj: TObject): TDataModule;
begin
  if IsSupportedType(AObj) then
    Result := TDSProviderDataModuleAdapter(AObj).ProviderDataModule
  else
    Result := nil;
end;

function TDSProviderServerClassAdapter.GetType: TPersistentClass;
begin
  Result := TDSProviderDataModuleAdapter;
end;

function TDSProviderServerClassAdapter.IsSupportedType(const AObj: TObject): Boolean;
begin
  Result := AObj.InheritsFrom(TProviderDataModule);
end;

function TDSProviderServerClassAdapter.IsSupportedType(const AClass: TClass): Boolean;
begin
  Result := AClass.InheritsFrom(TProviderDataModule);
end;

function TDSProviderServerClassAdapter.IsSupportedAdapterType(const AObj: TObject): Boolean;
begin
  Result := AObj is TDSProviderDataModuleAdapter;
end;

initialization
  TServerClassAdapterFactory.RegisterAdapterClass(sProviderServerAdapter, TDSProviderServerClassAdapter);

end.
