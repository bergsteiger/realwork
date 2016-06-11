{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       XML Transform Components                        }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.Xmlxform;

interface

uses
  Datasnap.DBClient, Datasnap.Provider, System.Classes, System.Types, Xml.XmlTransform;

type

{ TXMLTransformProvider }

  { This component takes data in an arbitrary XML data file and provides it to a
    DataSnap client.  It also takes updates to the data from the DataSnap client and
    modifies the original XML data file.

    Properties:

     CacheData
        Indicates if data is cached by the provider after the GetRecords
        method is called by the client.  Caching the data will speed
        the update process, but will consume additional resources.

      XMLDataFile
        XML File containing data to be returned to the client.  This can be
        in any format that can be transformed into a DataSnap compatible format.
        Updates are written back to this file.

      TransformRead.TransformationFile
        Transform file for for converting from XMLDataFile format into a
        DataSnap format.  This file must be created using the XMLMapper program.

      TransformWrite.TransformationFile
        Transform file for for converting from a DataSnap format into the
        XMLDataFile format. This file must be created using the XMLMapper
        program.
  }

  TXMLTransformProvider = class(TCustomProvider)
  private
    FDataCache: TClientDataSet;
    FResolver: TDataSetProvider;
    FTransformRead: TXMLTransform;
    FTransformWrite: TXMLTransform;
    FCacheData: Boolean;
    function GetXMLDataFile: string;
    procedure SetXMLDataFile(const Value: string);
  protected
    function InternalApplyUpdates(const Delta: OleVariant; MaxErrors: Integer;
      out ErrorCount: Integer): OleVariant; override;
    function InternalGetRecords(Count: Integer; out RecsOut: Integer;
      Options: TGetRecordOptions; const CommandText: OleStr;
      var Params: OleVariant): OleVariant; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property TransformRead: TXMLTransform read FTransformRead ;
    property TransformWrite: TXMLTransform read FTransformWrite ;
    property XMLDataFile: string read GetXMLDataFile write SetXMLDataFile;
    property CacheData: Boolean read FCacheData write FCacheData default False;
    property BeforeApplyUpdates;
    property AfterApplyUpdates;
    property BeforeGetRecords;
    property AfterGetRecords;
    property BeforeRowRequest;
    property AfterRowRequest;
    property OnDataRequest;
 end;

{ Transform Client }

  { This component takes data returned from a DataSnap AppServer and transforms
    it into an external XML data file (GetXML method).  The format of the XML is
    determined by the TransformGetData TransformationFile.

    It also allows inserting and deleting data on the AppServer by calling the
    calling ApplyUpdates method, passing an XML file with the data to
    insert/delete, and also a reference to a file containing the
    relavant transformation info. }

  TXMLTransformClient = class(TComponent)
  private
    FDataCache: TClientDataSet;
    FSetParamsDataCache: TClientDataSet;
    FLocalAppServer: TLocalAppServer;
    FTransformGetData: TXMLTransform;
    FTransformApplyUpdates: TXMLTransform;
    FTransformSetParams: TXMLTransform;
    function GetProviderName: string;
    function GetRemoteServer: TCustomRemoteServer;
    procedure SetProviderName(const Value: string);
    procedure SetRemoteServer(const Value: TCustomRemoteServer);
  protected
    procedure SetupAppServer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  GetDataAsXml(const PublishTransformFile: string): string; virtual;
    function  ApplyUpdates(const UpdateXML, UpdateTransformFile: string; MaxErrors: Integer): Integer; virtual;
    procedure SetParams(const ParamsXml, ParamsTransformFile: string);
  published
    property RemoteServer: TCustomRemoteServer read GetRemoteServer write SetRemoteServer;
    property ProviderName: string read GetProviderName write SetProviderName;
    property TransformGetData: TXMLTransform read FTransformGetData ;
    property TransformApplyUpdates: TXMLTransform read FTransformApplyUpdates;
    property TransformSetParams: TXMLTransform read FTransformSetParams ;
  end;

implementation

uses
  Data.DB, Datasnap.DSIntf, System.SysUtils, System.Variants, Xml.Xmldom, Xml.xmlutil;

{ Utility Functions }

// Helpers to reduce explicit casts
function VariantArrayToString(const V: OleVariant): string;
var
  LByteArray: TBytes;
begin
  LByteArray := Datasnap.DSIntf.VariantArrayToBytes(V);
  Result := TMarshal.ReadStringAsUtf8(TPtrWrapper.Create(LByteArray), Length(LByteArray) - 1);
end;

function StringToVariantArray(const S: string): OleVariant;
const
  CP_UTF8 = 65001;
var
  LArray: TArray<Byte>;
  Len: Integer;
  M: TMarshaller;
begin
  Len := LocaleCharsFromUnicode(CP_UTF8, 0, PWideChar(S), S.Length, nil, 0, nil, nil);
  SetLength(LArray, Len);
  Move(M.AsUtf8(S).ToPointer^, PByte(LArray)^, Len);
  Result := Datasnap.DSIntf.BytesToVariantArray(LArray);
end;

procedure StringToFile(const S, FileName: string);
begin
  with TStringList.Create do
  try
    Text := S;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

function GetXMLData(DataSet: TClientDataSet): string;
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('');
  try
    DataSet.SaveToStream(Stream, dfXML);
    Result := Stream.DataString;
  finally
    Stream.Free;
  end;
end;

function CreateNestedTransform(Owner: TComponent; const Name: string): TXMLTransform;
begin
  Result := TXMLTransform.Create(Owner);
  Result.SetSubComponent(True);
  Result.Name := Name;
end;


{ TXMLTransformProvider }

constructor TXMLTransformProvider.Create(AOwner: TComponent);
begin
  FTransformRead := CreateNestedTransform(Self, 'DataTransformRead'); // Do not localize
  FTransformWrite := CreateNestedTransform(Self, 'DataTransformWrite'); // Do not localize
  FDataCache := TClientDataSet.Create(Self);
  inherited;
end;

destructor TXMLTransformProvider.Destroy;
begin
  inherited;
end;

function TXMLTransformProvider.InternalGetRecords(Count: Integer;
  out RecsOut: Integer; Options: TGetRecordOptions;
  const CommandText: OleStr; var Params: OleVariant): OleVariant;
begin
  Result := StringtoVariantArray(FTransformRead.Data);
  if CacheData then
    FDataCache.Data := Result;
end;

function TXMLTransformProvider.InternalApplyUpdates(const Delta: OleVariant;
  MaxErrors: Integer; out ErrorCount: Integer): OleVariant;
var
  S: string;
begin
  if not Assigned(FResolver) then
  begin
    FResolver := TDataSetProvider.Create(Self);
    FResolver.DataSet := FDataCache;
    FResolver.ResolveToDataSet := True;
    FResolver.UpdateMode := upWhereAll; //upWhereKeyOnly;
  end;
  if not FCacheData or not FDataCache.Active then
    FDataCache.Data := StringToVariantArray(FTransformRead.Data);
  Result := FResolver.ApplyUpdates(Delta, MaxErrors, ErrorCount);
  FDataCache.MergeChangeLog;
  S := FTransformWrite.TransformXML(GetXMLData(FDataCache));
  if FTransformWrite.ResultDocument <> nil then
  begin
    SetEncoding(FTransformWrite.ResultDocument, FTransformRead.Encoding, False);
    if FTransformRead.SourceXmlFile <> '' then
      (FTransformWrite.ResultDocument as IDOMPersist).save(FTransformRead.SourceXmlFile);
  end
  else if S <> '' then
    StringToFile(S, FTransformRead.SourceXmlFile);
  if not FCacheData then
    FDataCache.Data := Null;
end;

function TXMLTransformProvider.GetXMLDataFile: string;
begin
  Result := FTransformRead.SourceXMLFile
end;

procedure TXMLTransformProvider.SetXMLDataFile(const Value: string);
begin
  FTransformRead.SourceXMLFile := Value;
end;

{ TXMLTransformClient }

constructor TXMLTransformClient.Create(AOwner: TComponent);
begin
  FTransformGetData := CreateNestedTransform(Self, 'TransformGetData'); // Do not localize
  FTransformApplyUpdates := CreateNestedTransform(Self, 'TransformApplyUpdates'); // Do not localize
  FTransformSetParams := CreateNestedTransform(Self, 'TransformSetParams'); // Do not localize
  FDataCache := TClientDataSet.Create(Self);
  inherited;
end;

destructor TXMLTransformClient.Destroy;
begin
  inherited;
  FLocalAppServer.Free;
end;

procedure TXMLTransformClient.SetupAppServer;
var
  ProvComp: TComponent;
begin
  if not Assigned(FDataCache.RemoteServer) or not FDataCache.HasAppServer then
  begin
    ProvComp := Owner.FindComponent(ProviderName);
    if Assigned(ProvComp) and (ProvComp is TCustomProvider) then
      FDataCache.AppServer := TLocalAppServer.Create(TCustomProvider(ProvComp));
  end;
end;

function TXMLTransformClient.GetDataAsXml(const PublishTransformFile: string): string;
var
  RecsOut: Integer;
  Params, OwnerData, VarPacket: OleVariant;
  TransFileName, XmlData: string;
  Options: TGetRecordOptions;
begin
  SetupAppServer;
  if FDataCache.Params.Count > 0 then
    Params := PackageParams(FDataCache.Params);
  Options :=  [grMetaData, grXML];
  VarPacket := FDataCache.AppServer.AS_GetRecords(GetProviderName, -1,
    RecsOut, Byte(Options), '', Params, OwnerData);
  XmlData := VariantArrayToString(VarPacket);
  if PublishTransformFile <> '' then
    TransFileName := PublishTransformFile else
    TransFileName := FTransformGetData.TransformationFile;
  Result := FTransformGetData.TransformXML(XMLData, TransFileName);
  if (Result <> '') and (FTransformGetData.ResultDocument <> nil) and
     (FTransformGetData.EncodingTrans <> '') then
    SetEncoding(FTransformGetData.ResultDocument,
      FTransformGetData.EncodingTrans, True);
end;

function TXMLTransformClient.ApplyUpdates(const UpdateXML, UpdateTransformFile: string;
  MaxErrors: Integer): Integer;
var
  Delta: Variant;
  OwnerData: OleVariant;
  TransFileName: string;
begin
  SetupAppServer;
  if UpdateTransformFile <> '' then
    TransFileName := UpdateTransformFile else
    TransFileName := FTransformApplyUpdates.TransformationFile;
  Delta := FTransformApplyUpdates.TransformXML(UpdateXML, TransFileName);
  try
    FDataCache.AppServer.AS_ApplyUpdates(GetProviderName,
      StringToVariantArray(Delta), MaxErrors, Result, OwnerData);
  except
  end;
end;

function TXMLTransformClient.GetProviderName: string;
begin
  Result := FDataCache.ProviderName;
end;

procedure TXMLTransformClient.SetProviderName(const Value: string);
begin
  FDataCache.ProviderName := Value;
end;

function TXMLTransformClient.GetRemoteServer: TCustomRemoteServer;
begin
  Result := FDataCache.RemoteServer;
end;

procedure TXMLTransformClient.SetRemoteServer(const Value: TCustomRemoteServer);
begin
  FDataCache.RemoteServer := Value;
end;

procedure TXMLTransformClient.SetParams(const ParamsXml, ParamsTransformFile: string);
var
  I: Integer;
  Field: TField;
  Param: TParam;
  S: string;
begin
  if FSetParamsdataCache = nil then
    FSetParamsdataCache := TClientDataSet.Create(Self);
  with FSetParamsdataCache do
  begin
    Active := False;

    S := FTransformSetParams.TransformXML(ParamsXML, ParamsTransformFile);
    Data := StringToVariantArray(S);

    if (Active) and (Fields.Count > 0) then
    begin
      First;
      if not EOF then
        for I := 0 to Fields.Count -1 do
        begin
          Field := Fields[I];
          Param := FDataCache.Params.FindParam(Field.FieldName);
          if Param = nil then
            Param := FDataCache.Params.CreateParam(Field.DataType, Field.FieldName, ptInput);
          Param.Value := Field.Value;
        end;
    end;
  end;
end;
end.
