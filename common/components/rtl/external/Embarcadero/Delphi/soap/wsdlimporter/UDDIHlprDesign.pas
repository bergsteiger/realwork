{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                UDDI Browser                           }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit UDDIHlprDesign;

interface

uses
  inquire_v1, Classes;

type

  { Interface that caches UDDI Search Results }
  IUDDIResultCache = interface
    { find_Business }
    function GetBusinessList: BusinessList;
    procedure SetBusinessList(const BL: BusinessList);

    { get_BusinessDetail }
    function GetBusinessDetail: BusinessDetail;
    procedure SetBusinessDetail(const BT: BusinessDetail);

    { get_ServiceDetail }
    function FindServiceDetail(serviceKey: String): ServiceDetail;
    procedure SetServiceDetail(const serviceKey: String; const SD: ServiceDetail);

    { get_tModelDetail }
    function FindTModelDetail(tModelKey: String): TModelDetail;
    procedure SetTModelDetail(const tModelKey: String; const TMD: TModelDetail);

    { Clear cached data }
    procedure Clear;

    property BusinessList: BusinessList read GetBusinessList write SetBusinessList;
    property BusinessDetail: BusinessDetail read GetBusinessDetail write SetBusinessDetail;
  end;

  { Interface that caches information about a binding we might want to import }
  IImportBindingInfo = interface
  ['{752A6BF3-0B91-4099-91E6-E0481AA2D460}']
    function  GetWSDLLocation: WideString;
    procedure SetWSDLLocation(const AWSDLLocation: WideString);

    function  GetUDDIOperator: WideString;
    procedure SetUDDIOperator(const AOperator: WideString);

    function  GetHostingRedirector: WideString;
    procedure SetHostingRedirector(const AHostRedirector: WideString);

    function  GetBindingKey: WideString;
    procedure SetBindingKey(const ABindingKey: WideString);

    function  GetSOAPEndpoint: WideString;
    procedure SetSOAPEndpoint(const ASOAPEndpoint: WideString);

    property  WSDLLocation: WideString read GetWSDLLocation write SetWSDLLocation;
    property  UDDIOperator: WideString read GetUDDIOperator write SetUDDIOperator;
    property  BindingKey: WideString read GetBindingKey write SetBindingKey;
    property  SOAPEndpoint: WideString read GetSOAPEndpoint write SetSOAPEndpoint;
    property  HostingRedirector: WideString read GetHostingRedirector write SetHostingRedirector;
  end;

{ Returns object that can cache Search Result }
function GetUDDIResultCache: IUDDIResultCache;

{ Returns object that implements IImportBindingInfo }
function GetImportBindingInfo: IImportBindingInfo;

{ Wrappers around UDDI API }
function FindBus(const Service: InquireSoap; maxRows: Integer; const Name: String;
                 ExactMatch: Boolean; CaseSensitive: Boolean): BusinessList; overload;
function FindBus(const Service: InquireSoap; maxRows: Integer; const DiscURLs: TStrings): BusinessList; overload;
function FindSvc(const Service: InquireSoap;
                 maxRows: Integer;
                 const Name: String;
                 ExactMatch: Boolean;
                 CaseSensitive: Boolean): ServiceList;
function GetSvcDetail(const Service: InquireSoap; const sKey: String): ServiceDetail;
function GetBusDetail(const Service: InquireSoap; const bInfo: BusinessInfo): BusinessDetail;
function GetTModDetail(const Service: InquireSoap; const tModKey: String): TModelDetail;

function GetTModelOfWSDL(const TMD: TModelDetail): TModel; overload;
function GetTModelOfWSDL(const Service: InquireSoap; const tModKey: String): TModel; overload;

function GetBindingkeyDetail(const Service: InquireSoap; const key: String): BindingDetail; overload;
function GetBindingkeyDetail(const Operator: String; const key: String): BindingDetail; overload;

function GetBindingkeyImportInfo(const Operator: String; const key: String): IImportBindingInfo; overload;
function GetBindingkeyImportInfo(const Service: InquireSOAP; const Operator: String; const key: String): IImportBindingInfo; overload;

function GetWSDL(const Service: InquireSoap; const BTemplate: BindingTemplate; var WSDL: string): Boolean; overload;
function GetWSDL(const Operator: String; const key: String): String; overload;
function GetWSDL(const Service: InquireSOAP; const key: String): String; overload;
function GetWSDL(const Service: InquireSOAP; const BD: BindingDetail): String; overload;

implementation

uses
  SysUtils, Contnrs, SOAPHTTPClient;

type

  { Implements IUDDIResultCache }
  TUDDIResultCache = class(TInterfacedObject, IUDDIResultCache)
  private
    FBusinessList: BusinessList;
    FBusinessDetail: BusinessDetail;
    FServiceDetailList: TObjectList;
    FTModelDetailList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetBusinessList: BusinessList;
    procedure SetBusinessList(const BL: BusinessList);
    function GetBusinessDetail: BusinessDetail;
    procedure SetBusinessDetail(const BT: BusinessDetail);
    function FindServiceDetail(serviceKey: String): ServiceDetail;
    procedure SetServiceDetail(const serviceKey: String; const SD: ServiceDetail);
    function FindTModelDetail(tModelKey: String): TModelDetail;
    procedure SetTModelDetail(const tModelKey: String; const TMD: TModelDetail);
    procedure Clear;
  end;


function GetSvcDetail(const Service: InquireSoap; const sKey: String): ServiceDetail;
var
  GSD: GetServiceDetail;
  keys: serviceKey;
begin
  GSD := GetServiceDetail.Create;
  try
    SetLength(keys, 1);
    keys[0] := sKey;
    GSD.serviceKey := keys;
    GSD.generic := '1.0';
    Result := Service.get_serviceDetail(GSD);
  finally
    GSD.Free;
  end;
end;

function FindBus(const Service: InquireSoap;
                 maxRows: Integer; const DiscURLs: TStrings): BusinessList;
var
  FB: find_business;
  DU: DiscoveryURLs;
  DUrls: discoveryUrl2;
  I: Integer;
begin
  FB := find_business.Create;
  try
    FB.generic := '1.0';
    FB.maxRows := maxRows;

    DU := DiscoveryURLS.Create;
    try
      SetLength(DUrls, DiscURLs.Count);
      for I := 0 to DiscURLs.Count-1 do
      begin
        DUrls[I] := DiscoveryURL.Create;
        DUrls[I].DiscoveryUrl := DiscURLs[I];
//        DUrls[I] := DiscURLs[I];
      end;
      DU.discoveryUrl := DUrls;
      FB.discoveryURLs := DU;
      Result := Service.find_business(FB);
    finally
      { DU.Free; - Freed by FindBusiness.Destroy }
    end;
  finally
    FB.Free;
  end;
end;

function FindBus(const Service: InquireSoap;
                 maxRows: Integer;
                 const Name: String;
                 ExactMatch: Boolean;
                 CaseSensitive: Boolean): BusinessList;
var
  FB: find_business;
  FQ: findQualifier;
begin
  FB := find_business.Create;
  try
    FB.generic := '1.0';
    FB.maxRows := maxRows;
    FB.name := Name;

   { ExactMatch? }
    if ExactMatch then
    begin
      SetLength(FQ, Length(FQ)+1);
      FQ[Length(FQ)-1] := 'exactNameMatch';       { do not localize }
    end;

    { Case Sensitive ? }
    if CaseSensitive then
    begin
      SetLength(FQ, Length(FQ)+1);
      FQ[Length(FQ)-1] := 'caseSensitiveMatch';   { do not localize }
    end;

    { Set search qualifiers, if any }
    if Length(FQ) > 0 then
    begin
      FB.findQualifiers := FindQualifiers.Create;
      FB.findQualifiers.findQualifier := FQ;
    end;
    Result := Service.find_business(FB);
  finally
    FB.Free;
  end;
end;

function FindSvc(const Service: InquireSoap;
                 maxRows: Integer;
                 const Name: String;
                 ExactMatch: Boolean;
                 CaseSensitive: Boolean): ServiceList;
var
  FS: find_service;
  FQ: findQualifier;
begin
  FS := find_service.Create;
  try
    FS.generic := '1.0';
    FS.maxRows := maxRows;
    FS.name := Name;
//    FS.businessKey := '*';

   { ExactMatch? }
    if ExactMatch then
    begin
      SetLength(FQ, Length(FQ)+1);
      FQ[Length(FQ)-1] := 'exactNameMatch';       { do not localize }
    end;

    { Case Sensitive ? }
    if CaseSensitive then
    begin
      SetLength(FQ, Length(FQ)+1);
      FQ[Length(FQ)-1] := 'caseSensitiveMatch';   { do not localize }
    end;

    { Set search qualifiers, if any }
    if Length(FQ) > 0 then
    begin
      FS.findQualifiers := FindQualifiers.Create;
      FS.findQualifiers.findQualifier := FQ;
    end;
    Result := Service.find_service(FS);
  finally
    FS.Free;
  end;
end;

function GetBusDetail(const Service: InquireSoap; const bInfo: BusinessInfo): BusinessDetail;
var
  GBD: GetBusinessDetail;
  keys: inquire_v1.businessKey;
begin
  GBD := GetBusinessDetail.Create;
  try
    SetLength(keys, 1);
    keys[0] := bInfo.businessKey;
    GBD.businessKey := keys;
    GBD.generic := '1.0';
    Result := Service.get_businessDetail(GBD);
  finally
    GBD.Free;
  end;
end;

function GetTModDetail(const Service: InquireSoap; const tModKey: String): TModelDetail;
var
  GTM: GetTModelDetail;
  keys: tModelKey;
begin
  GTM := GetTModelDetail.Create;
  try
    GTM.generic := '1.0';
    SetLength(keys, 1);
    keys[0] := tModKey;
    GTM.tModelKey := keys;
    Result := Service.get_tModelDetail(GTM);
  finally
    GTM.Free;
  end;
end;

function GetTModelOfWSDL(const TMD: TModelDetail): TModel; overload;
var
  I, J: Integer;
  TM: TModel;
begin
  Result := nil;
  if Assigned(TMD) then
  begin
    for I := 0 to TMD.Len-1 do
    begin
      TM := TMD[I];
      if Assigned(TM.overviewDoc) then
      begin
        { TM.overviewDoc.description }
        { TM.overviewDoc.overviewURL }
        { TM.operator }
        if Assigned(TM.categoryBag) then
        begin
          for J := 0 to TM.categoryBag.Len-1 do
          begin
            if (TM.categoryBag[J].tModelKey = 'uuid:C1ACF26D-9672-4404-9D70-39B756E62AB4') or
               (TM.categoryBag[J].keyValue = 'wsdlSpec') then
              Result := TM;
          end;
        end;
      end;
    end;
  end;
end;

function GetTModelOfWSDL(const Service: InquireSoap; const tModKey: String): TModel; overload;
var
  TMD: TModelDetail;
begin
  Result := nil;
  TMD := GetTModDetail(Service, tModKey);
  try
    GetTModelOfWSDL(TMD);
  finally
    TMD.Free;
  end;
end;

function GetUDDIService(const Operator: String): InquireSOAP;
var
  HTTPRIO: THTTPRIO;
begin
  Result := nil;
  HTTPRIO := THTTPRIO.Create(nil);
  try
    Result := HTTPRIO as InquireSOAP;
    HTTPRIO.URL := Operator;
  finally
    if Result = nil then
      HTTPRIO.Free;
  end;
end;

function GetBindingkeyDetail(const Operator: String; const key: String): BindingDetail;
var
  Service: InquireSOAP;
begin
  Service := GetUDDIService(Operator);
  Result := GetBindingkeyDetail(Service, key);
end;

function GetBindingkeyDetail(const Service: InquireSoap; const key: String): BindingDetail;
var
  GBD: GetBindingDetail;
  BK: bindingKey;
begin
  GBD := GetBindingDetail.Create;
  try
    GBD.generic := '1.0';
    SetLength(BK, 1);
    BK[0] := key;
    GBD.bindingKey := BK;
    Result := Service.get_bindingDetail(GBD);
  finally
    GBD.Free;
  end;
end;

function GetBindingkeyImportInfo(const Operator: String; const key: String): IImportBindingInfo;
var
  Service: InquireSOAP;
begin
  Service := GetUDDIService(Operator);
  Result := GetBindingkeyImportInfo(Service, Operator, key);
end;

function GetBindingkeyImportInfo(const Service: InquireSOAP;
                                 const Operator: String;
                                 const key: String): IImportBindingInfo;
var
  BD: BindingDetail;
begin
  Result := nil;
  BD := GetBindingkeyDetail(Service, key);
  try
    if BD.Len > 0 then
    begin
      Result := GetImportBindingInfo;
      if Assigned(BD[0].accessPoint) then
        Result.SOAPEndpoint := BD[0].accessPoint.AccessPoint;
      Result.UDDIOperator := Operator;
      Result.BindingKey := Key;
      Result.WSDLLocation := GetWSDL(Service, BD);
    end;
  finally
    BD.Free;
  end;
end;

function GetWSDL(const Service: InquireSoap;
                 const BTemplate: BindingTemplate;
                 var WSDL: string): Boolean;
var
  I: Integer;
  TModInstDetails: TModelInstanceDetails;
  TModDetail: TModelDetail;
  TM: TModel;
begin
  Result := System.False;
  if Assigned(BTemplate) then
  begin
    if Assigned(BTemplate.tModelInstanceDetails) then
    begin
      TModInstDetails := BTemplate.tModelInstanceDetails;
      if TModInstDetails.Len > 0 then
      begin
        for I := 0 to TModInstDetails.Len-1 do
        begin
          TModDetail := GetTModDetail(Service, TModInstDetails[I].tModelKey);
          TM := GetTModelOfWSDL(TModDetail);
          if Assigned(TM) then
          begin
            { Here we've found a WSDL }
            Result := System.True;
            WSDL := TM.overviewDoc.overviewURL;
            break;
          end;
        end;
      end;
    end;
  end;
end;


function GetWSDL(const Service: InquireSOAP; const BD: BindingDetail): String;
var
  BT: BindingTemplate;
  I: Integer;
begin
  Result := '';
  if BD.Len > 0 then
  begin
    for I := 0 to BD.Len-1 do
    begin
      BT := BD[I];
      if GetWSDL(Service, BT, Result) then
        Exit;
    end;
  end;
end;

function GetWSDL(const Service: InquireSOAP; const key: String): String;
var
  BD: BindingDetail;
begin
  BD := GetBindingkeyDetail(Service, key);
  try
    Result := GetWSDL(Service, BD);
  finally
    BD.Free;
  end;
end;

function GetWSDL(const Operator: String; const key: String): String;
var
  Service: InquireSOAP;
begin
  Service := GetUDDIService(Operator);
  Result := GetWSDL(Service, key);
end;

function GetUDDIResultCache: IUDDIResultCache;
begin
  Result := TUDDIResultCache.Create;
end;

{ TUDDIResultCache }

procedure TUDDIResultCache.Clear;
begin
  FServiceDetailList.Clear;
  FTModelDetailList.Clear;
  FreeAndNil(FBusinessList);
  FreeAndNil(FBusinessDetail);
end;

constructor TUDDIResultCache.Create;
begin
  inherited Create;
  FServiceDetailList := TObjectList.Create(System.True);
  FTModelDetailList := TObjectList.Create(System.True);
end;

destructor TUDDIResultCache.Destroy;
begin
  FreeAndNil(FBusinessList);
  FreeAndNil(FBusinessDetail);
  FServiceDetailList.Free;
  FTModelDetailList.Free;
  inherited;
end;

function TUDDIResultCache.FindServiceDetail(serviceKey: String): ServiceDetail;
var
  I: Integer;
  SD: ServiceDetail;
begin
  for I := 0 to FServiceDetailList.Count-1 do
  begin
    SD := ServiceDetail(FServiceDetailList.Items[I]);
    if Assigned(SD) and
       (SD.Len > 0) and
       (SD[0].serviceKey = serviceKey) then
    begin
      Result := SD;
      Exit;
    end;
  end;
  Result := nil;
end;

function TUDDIResultCache.FindTModelDetail(tModelKey: String): TModelDetail;
var
  I, J: Integer;
  TMD: TModelDetail;
begin
  for I := 0 to FTModelDetailList.Count-1 do
  begin
    TMD := TModelDetail(FTModelDetailList.Items[I]);
    if Assigned(TMD) then
    begin
      for J := 0 to TMD.Len-1 do
      begin
        if TMD[J].tModelKey = tModelKey then
        begin
          Result := TMD;
          Exit;
        end;
      end;
    end;
  end;
  Result := nil;
end;

function TUDDIResultCache.GetBusinessDetail: BusinessDetail;
begin
  Result := FBusinessDetail;
end;

function TUDDIResultCache.GetBusinessList: BusinessList;
begin
  Result := FBusinessList;
end;

procedure TUDDIResultCache.SetBusinessDetail(const BT: BusinessDetail);
begin
  FreeAndNil(FBusinessDetail);
  FBusinessDetail := BT;
end;

procedure TUDDIResultCache.SetBusinessList(const BL: BusinessList);
begin
  FreeAndNil(FBusinessList);
  FBusinessList := BL;
end;

procedure TUDDIResultCache.SetServiceDetail(const serviceKey: String;
  const SD: ServiceDetail);
begin
  { NOTE: No need to check if object is already in list since caller
          will first do a Find before invoking this method!! }
  FServiceDetailList.Add(SD);
end;

procedure TUDDIResultCache.SetTModelDetail(const tModelKey: String;
  const TMD: TModelDetail);
begin
  { NOTE: No need to check if object is already in list since caller
          will first do a Find before invoking this method!! }
  FTModelDetailList.Add(TMD);
end;

type

  TImportBindingInfo = class(TInterfacedObject, IImportBindingInfo)
  private
    FUDDIOperator: WideString;
    FWSDLLocation: WideString;
    FHostingRedirector: WideString;
    FBindingKey: WideString;
    FSOAPEndpoint: WideString;
  public
    function GetUDDIOperator: WideString;
    procedure SetUDDIOperator(const AOperator: WideString);

    function GetWSDLLocation: WideString;
    procedure SetWSDLLocation(const AWSDLLocation: WideString);

    function GetHostingRedirector: WideString;
    procedure SetHostingRedirector(const AHostRedirector: WideString);

    function GetBindingKey: WideString;
    procedure SetBindingKey(const ABindingKey: WideString);

    function GetSOAPEndpoint: WideString;
    procedure SetSOAPEndpoint(const ASOAPEndpoint: WideString);
  end;

function GetImportBindingInfo: IImportBindingInfo;
begin
  Result := TImportBindingInfo.Create;
end;

{ TImportBindingInfo }

function TImportBindingInfo.GetBindingKey: WideString;
begin
  Result := FBindingKey;
end;

function TImportBindingInfo.GetHostingRedirector: WideString;
begin
  Result := FHostingRedirector;
end;

function TImportBindingInfo.GetSOAPEndpoint: WideString;
begin
  Result := FSOAPEndpoint;
end;

function TImportBindingInfo.GetUDDIOperator: WideString;
begin
  Result := FUDDIOperator;
end;

function TImportBindingInfo.GetWSDLLocation: WideString;
begin
  Result := FWSDLLocation;
end;

procedure TImportBindingInfo.SetBindingKey(const ABindingKey: WideString);
begin
  FBindingKey := ABindingKey;
end;

procedure TImportBindingInfo.SetHostingRedirector(
  const AHostRedirector: WideString);
begin
  FHostingRedirector := AHostRedirector;
end;

procedure TImportBindingInfo.SetSOAPEndpoint(
  const ASOAPEndpoint: WideString);
begin
  FSOAPEndpoint := ASOAPEndpoint;
end;

procedure TImportBindingInfo.SetUDDIOperator(const AOperator: WideString);
begin
  FUDDIOperator := AOperator;
end;

procedure TImportBindingInfo.SetWSDLLocation(
  const AWSDLLocation: WideString);
begin
  FWSDLLocation := AWSDLLocation;
end;

end.

