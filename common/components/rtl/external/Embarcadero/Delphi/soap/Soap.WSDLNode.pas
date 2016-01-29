{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.WSDLNode;

interface

uses
  System.Classes, System.SysUtils, System.TypInfo, Soap.IntfInfo,
  Soap.SOAPAttachIntf, Soap.WebNode, Soap.WSDLItems, Soap.WSDLIntf, Xml.XMLIntf;

type

  { To report errors loading WSDLs }
  EWSDLLoadException = class(Exception)
  end;

  TWSDLView = class(TComponent)
  private
    FUserName: string;
    FPassword: string;
    FProxy: string;
    FPortType: string;
    FPort: string;
    FOperation: string;
    FService: string;
    FWSDL: TWSDLItems;
    FIWSDL: IXMLDocument;
    procedure SetWSDL(Value: TWSDLItems);
    procedure SetOperation(const Op: string);
    function  GetService: String;
    function  GetPort: String;
  public
    IntfInfo: PTypeInfo;
    procedure Activate;
    procedure SetDesignState(Designing: Boolean);
  published
    property PortType: string read FPortType write FPortType;
    property Port: string read GetPort write FPort;
    property Operation: string read FOperation write SetOperation;
    property Service: string read GetService write FService;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
    property Proxy: string read FProxy write FProxy;
    property WSDL: TWSDLItems read FWSDL write SetWSDL;
  end;

  TWSDLClientNode = class(TComponent, IWebNode)
  private
    FWSDLView: TWSDLView;
    FTransportNode: IWebNode;
    procedure SetTransportNode(Value: IWebNode);
  protected
{$IFDEF NEXTGEN}
    function GetMimeBoundary: string;
    procedure SetMimeBoundary(const Value: string);
{$ELSE !NEXTGEN}
    function GetMimeBoundary: AnsiString;
    procedure SetMimeBoundary(const Value: AnsiString);
{$ENDIF NEXTGEN}
    function  GetWebNodeOptions: WebNodeOptions;
    procedure SetWebNodeOptions(Value: WebNodeOptions);
  public
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Execute(const DataMsg: string; Resp: TStream); overload;
    procedure Execute(const Request: TStream; Response: TStream); overload;
    function  Execute(const Request: TStream): TStream; overload;
    procedure BeforeExecute(const IntfMetaData: TIntfMetaData;
                            const MethodMetaData: TIntfMethEntry;
                            MethodIndex: Integer;
                            AttachHandler: IMimeAttachmentHandler);

  published
    property WSDLView: TWSDLView read FWSDLView write FWSDLView;
    property TransportNode: IWebNode read FTransportNode  write SetTransportNode;
  end;

function ActivateWSDL(WSDL: TWSDLItems; const Name: string; const Password: string; const Proxy: string): Boolean;

implementation

uses
  Soap.SOAPConst, Xml.xmldom;

{ ActivateWSDL }
function ActivateWSDL(WSDL: TWSDLItems; const Name: string; const Password: string; const Proxy: string): Boolean;
begin
  Result := True;
  try
    if (not WSDL.Active) then 
    begin
      WSDL.StreamLoader.UserName := Name;
      WSDL.StreamLoader.Password := Password;
      WSDL.StreamLoader.Proxy := Proxy;
      WSDL.Load(WSDL.FileName);
    end
  except
    on E: EDOMParseError do
      raise EWSDLLoadException.CreateFmt(SWSDLError, [WSDL.Filename, E.Message]);
  end;
end;

{ TWSDLClientNode }

{$IFDEF NEXTGEN}
function TWSDLClientNode.GetMimeBoundary: string;
begin
  Result := '';
end;
{$ELSE !NEXTGEN}
function TWSDLClientNode.GetMimeBoundary: AnsiString;
begin
end;
{$ENDIF NEXTGEN}

{$IFDEF NEXTGEN}
procedure TWSDLClientNode.SetMimeBoundary(const Value: string);
{$ELSE !NEXTGEN}
procedure TWSDLClientNode.SetMimeBoundary(const Value: AnsiString);
{$ENDIF NEXTGEN}
begin
end;

function TWSDLClientNode.GetWebNodeOptions: WebNodeOptions;
begin
  Result := FTransportNode.Options;
end;

procedure TWSDLClientNode.SetWebNodeOptions(Value: WebNodeOptions);
begin
  FTransportNode.Options := Value;
end;

procedure TWSDLClientNode.Execute(const Request: TStream; Response: TStream);
begin
end;

procedure  TWSDLClientNode.Execute(const DataMsg: String; Resp: TStream);
begin
end;

function TWSDLClientNode.Execute(const Request: TStream): TStream;
begin
  Result := nil;
end;

procedure TWSDLClientNode.BeforeExecute(const IntfMetaData: TIntfMetaData;
                                        const MethodMetaData: TIntfMethEntry;
                                        MethodIndex: Integer;
                                        AttachHandler: IMimeAttachmentHandler);
begin
end;

procedure TWSDLClientNode.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and AComponent.IsImplementorOf(FTransportNode) then
    FTransportNode := nil;
end;

procedure TWSDLClientNode.SetTransportNode(Value: IWebNode);
begin
  if Assigned(Value) then
  begin
    ReferenceInterface(FTransportNode, opRemove);
    FTransportNode := Value;
    ReferenceInterface(FTransportNode, opInsert);
  end;
end;

{ TWSDLView }

procedure TWSDLView.SetDesignState(Designing: Boolean);
begin
  SetDesigning(Designing);
end;

procedure TWSDLView.SetWSDL(Value: TWSDLItems);
begin
  if Assigned(Value) then
  begin
    FWSDL := Value;
    FIWSDL := Value as IXMLDocument;
  end;
end;

procedure TWSDLView.Activate;
begin
  if Assigned(FWSDL) then
  begin
    ActivateWSDL(FWSDL, UserName, Password, Proxy);
  end;
end;

function TWSDLView.GetService: String;
var
  List: TDOMStrings;
begin
  Result := FService;
  if Result = '' then
  begin
    { See if we can deduce the Service - i.e. if there's only one }
    if Assigned(FWSDL) and not (csDesigning in ComponentState) then
    begin
      Activate;
      List := TDOMStrings.Create;
      try
        FWSDL.GetServices(List);
        if List.Count = 1 then
          FService := List.Strings[0];
        Result := FService;
      finally
        List.Free;
      end;
    end;
  end;
end;

function TWSDLView.GetPort: String;
var
  List: TDOMStrings;
  Svc: string;
begin
  Result := FPort;
  if Result = '' then
  begin
    { See if we can deduce the Port - i.e. if there's only one }
    if Assigned(FWSDL) and not (csDesigning in ComponentState) then
    begin
      Svc := Service;
      if (Svc <> '') then
      begin
        List := TDOMStrings.Create;
        try
          FWSDL.GetPortsForService(Svc, List);
          if List.Count = 1 then
            FPort := List.Strings[0];
          Result := FPort;
        finally
          List.Free;
        end;
      end;
    end;
  end;
end;

procedure TWSDLView.SetOperation(const Op: string);
begin
  FOperation := Op;
end;

end.
