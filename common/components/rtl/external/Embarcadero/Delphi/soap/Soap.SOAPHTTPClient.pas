{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.SOAPHTTPClient;

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

interface

uses
  System.Classes, Soap.OPToSOAPDomConv, Soap.Rio, Soap.SOAPHTTPTrans,
  Soap.WSDLItems, Soap.WSDLNode, Xml.XMLIntf;

type
  THTTPRIO = class(TRIO)
  private
    FWSDLItems: TWSDLItems;
    WSDLItemDoc: IXMLDocument;
    FWSDLView: TWSDLView;
    FWSDLLocation: string;
    FDOMConverter:  TOPToSoapDomConvert;
    FHTTPWebNode: THTTPReqResp;
    FDefaultConverter: TOPToSoapDomConvert;
    FDefaultWebNode: THTTPReqResp;
    procedure ClearDependentWSDLView;
    procedure SetWSDLLocation(Value: string);
    function  GetPort: string;
    procedure SetPortValue(Value: string);
    function  GetService: string;
    procedure SetService(Value: string);
    procedure CheckWSDLView;
    procedure SetURL(Value: string);

    function  GetDomConverter: TOpToSoapDomConvert;
    procedure SetDomConverter(Value: TOPToSoapDomConvert);

    function  GetHTTPWebNode: THTTPReqResp;
    procedure SetHTTPWebNode(Value: THTTPReqResp);

    function  GetURL: string;
    function  GetDefaultWebNode: THTTPReqResp;
    function  GetDefaultConverter: TOPToSoapDomConvert;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
    property WSDLItems: TWSDLItems read FWSDLItems;
  published
    property WSDLLocation: string read FWSDLLocation  write SetWSDLLocation;
    property Service: string read GetService write SetService;
    property Port: string read GetPort write SetPortValue;
    property URL: string read GetURL write SetURL;
    property HTTPWebNode: THTTPReqResp read GetHTTPWebNode write SetHTTPWebNode;
    property Converter: TOPToSoapDomConvert read GetDomConverter write SetDOMConverter;
  end;


implementation

uses
  System.SysUtils, Soap.InvokeRegistry, Soap.OPConvert, Soap.WebNode;

constructor THTTPRIO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  { Converter }
  FDomConverter := GetDefaultConverter;
  FConverter := FDomConverter as IOPConvert;
  { WebNode }
  FHTTPWebNode := GetDefaultWebNode;
  FWebNode := FHTTPWebNode as IWebNode;
end;

destructor THTTPRIO.Destroy;
begin
  if Assigned(FConverter) then
    FConverter := nil;
  if Assigned(FWebNode) then
    FWebNode := nil;
  if Assigned(FWSDLView) then
    FWSDLView.Free;

  { All components we own are automatically cleaned up }
  inherited;
end;

function THTTPRIO.GetDefaultWebNode: THTTPReqResp;
begin
  if (FDefaultWebNode = nil) then
  begin
    FDefaultWebNode := THTTPReqResp.Create(Self);
    FDefaultWebNode.Name := 'HTTPWebNode1';                { do not localize }
    FDefaultWebNode.SetSubComponent(True);
  end;
  Result := FDefaultWebNode;
end;

function THTTPRIO.GetDefaultConverter: TOPToSoapDomConvert;
begin
  if (FDefaultConverter = nil) then
  begin
    FDefaultConverter := TOPToSoapDomConvert.Create(Self);
    FDefaultConverter.Name := 'Converter1';                 { do not localize }
    FDefaultConverter.SetSubComponent(True);
  end;
  Result := FDefaultConverter;
end;

procedure THTTPRIO.ClearDependentWSDLView;
begin
  if Assigned(FDomConverter) and Assigned(FDOMConverter.WSDLView) then
    FDOMConverter.WSDLView := nil;
  if Assigned(FHTTPWebNode) and Assigned(FHTTPWebNode.WSDLView) then
    FHTTPWebNode.WSDLView := FWSDLView;
end;

procedure THTTPRIO.CheckWSDLView;
begin
  if not Assigned(FWSDLItems) then
  begin
    if not Assigned(FWSDLItems) then
    begin
      FWSDLItems := TWSDLItems.Create(nil);
      WSDLItemDoc := FWSDLItems;
    end;
    if not Assigned(FWSDLView) then
    begin
      FWSDLView := TWSDLView.Create(nil);
      FWSDLView.SetDesignState(csDesigning in ComponentState);
    end;
    FWSDLView.WSDL := FWSDLItems;
    if Assigned(FDomConverter) then
      FDOMConverter.WSDLView := FWSDLView;
    if Assigned(FHTTPWebNode) then
      FHTTPWebNode.WSDLView := FWSDLView;
  end;
end;

function THTTPRIO.GetPort: string;
begin
  if Assigned(FWSDLView) then
    Result := FWSDLView.Port
  else
    Result := '';
end;

function THTTPRIO.GetService: string;
begin
  if Assigned(FWSDLView) then
    Result := FWSDLView.Service
  else
    Result := '';
end;

procedure THTTPRIO.SetPortValue(Value: string);
begin
  if Assigned(FWSDLView) then
    FWSDLView.Port := Value;
end;

procedure THTTPRIO.SetService(Value: string);
begin
  if Assigned(FWSDLView) then
    FWSDLView.Service := Value;
end;

procedure THTTPRIO.SetURL(Value: string);
begin
  if Assigned(FHTTPWebNode) then
  begin
    FHTTPWebNode.URL := Value;
    if Value <> '' then
    begin
      WSDLLocation := '';
      ClearDependentWSDLView;
    end;
  end;
end;

procedure THTTPRIO.SetWSDLLocation(Value: string);
begin
  { WSDLLocation and URL are currently mutually exclusive }
  { So clear out URL if we're setting a WSDLLocation }
  if (Value <> '') and (URL <> '') then
    FHTTPWebNode.URL := '';
  { Clear any currently cached WSDLs.
    NOTE: A RIO can only be bound to one given interface.
          Therefore switching WSDL will be a rather rare
          scenario. However, it's possible to have multiple
          Services that implement the same portype but
          expose different WSDLs. Case in point is the
          Interop Service that are exposed by various
          SOAP vendors. So to that end, we'll clear
          the WSDL Cache }
  if Assigned(FWSDLItems) and (WSDLItemDoc <> nil) then
  begin
    WSDLItemDoc := nil;
    FWSDLItems := nil;
  end;
  { This will recreate the WSDLView/Items }
  CheckWSDLView;
  { Deactivate }
  if FWSDLItems.Active then
    FWSDLItems.Active  := False;
  FWSDLLocation := Value;
  { Store the WSDLLocation as the FileName of the TWSDLItems }
  FWSDLItems.FileName := Value;
  FWSDLView.Port := '';
  FWSDLView.Service := '';
end;

function THTTPRIO.QueryInterface(const IID: TGUID; out Obj): HResult;
var
  UDDIOperator, UDDIBindingKey: string;
begin
  Result := inherited QueryInterface(IID, Obj);
  { Here we check if we just bounded to an interface - and if yes, we retrieve
    & update items that are HTTP/transport specific }
  if Result = 0 then
  begin
    if IsEqualGUID(IID, FIID) then
    begin
      FHTTPWebNode.SoapAction := InvRegistry.GetActionURIOfIID(IID);
      if InvRegistry.GetUDDIInfo(IID, UDDIOperator, UDDIBindingKey) then
      begin
        FHTTPWebNode.UDDIOperator := UDDIOperator;
        FHTTPWebNode.UDDIBindingKey := UDDIBindingKey;
      end;
    end;
  end;
end;

function THTTPRIO.GetDomConverter: TOPToSoapDomConvert;
begin
  if not Assigned(FDomConverter) then
  begin
    FDomConverter := GetDefaultConverter;
    FConverter := FDomConverter as IOPConvert;
  end;
  Result := FDomConverter;
end;

procedure THTTPRIO.SetDomConverter(Value: TOPToSoapDomConvert);
begin
  if Assigned(FDOMConverter) and (FDomConverter.Owner = Self) then
  begin
    FConverter := nil;
    if FDomConverter <> FDefaultConverter then
      FDomConverter.Free;
  end;
  FDomConverter := Value;
  if Value <> nil then
  begin
    FConverter := Value as IOPConvert;
    FDomConverter.FreeNotification(Self);
    FDomConverter.WSDLView := FWSDLView;
  end;
end;

function THTTPRIO.GetHTTPWebNode: THTTPReqResp;
begin
  if not Assigned(FHTTPWebNode) then
  begin
    FHTTPWebNode := GetDefaultWebNode;
    FWebNode := FHTTPWebNode as IWebNode;
  end;
  Result := FHTTPWebNode;
end;

procedure THTTPRIO.SetHTTPWebNode(Value: THTTPReqResp);
var
  URL, UDDIOperator, UDDIBindingKey: string;
begin
  if Assigned(FHTTPWebNode) then
  begin
    { Save previous endpoint configuration }
    URL := FHTTPWebNode.URL;
    UDDIOperator := FHTTPWebNode.UDDIOperator;
    UDDIBindingKey := FHTTPWebNode.UDDIBindingKey;

    { Cleanup if we're owner and it's not out default one }
    if (FHTTPWebNode.Owner = Self) and (FHTTPWebNode <> FDefaultWebNode) then
    begin
      FWebNode := nil;
      FHTTPWebNode.Free;
    end
  end
  else
  begin
    URL := '';
    UDDIOperator := '';
    UDDIBindingKey := '';
  end;

  FHTTPWebNode := Value;

  if Value <> nil then
  begin
    FWebNode := Value as IWebNode;
    { Make sure we get notified so we may cleanup properly }
    FHTTPWebNode.FreeNotification(Self);
    { WSDLView }
    FHTTPWebNode.WSDLView := FWSDLView;
  end
  else
  begin
    FHTTPWebNode := FDefaultWebNode;
    FWebNode := FHTTPWebNode as IWebNode;
  end;

  { Transfer previous endpoint configuration }
  if FHTTPWebNode <> nil then
  begin
    if (URL <> '') and (FHTTPWebNode.URL = '') then
      FHTTPWebNode.URL := URL;
    if (UDDIOperator <> '') and (FHTTPWebNode.UDDIOperator = '') then
      FHTTPWebNode.UDDIOperator := UDDIOperator;
    if (UDDIBindingKey <> '') and (FHTTPWebNode.UDDIBindingKey = '') then
      FHTTPWebNode.UDDIBindingKey := UDDIBindingKey;
  end;
end;

function THTTPRIO.GetURL: string;
begin
  if Assigned(FHTTPWebNode) then
    Result := FHTTPWebNode.URL
  else
    Result := '';
end;

procedure THTTPRIO.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FHTTPWebNode) then
  begin
    FWebNode := nil;
    FHTTPWebNode := nil;
  end;
  if (Operation = opRemove) and (AComponent = FDomConverter) then
  begin
    FConverter := nil;
    FDomConverter := nil;
  end;
end;

end.
