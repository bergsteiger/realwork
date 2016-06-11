{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  SOAP Support                         }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Soap.SOAPLinked;

interface

uses
  System.Classes, System.SysUtils, System.TypInfo,
  Soap.IntfInfo, Soap.InvokeRegistry, Soap.OPToSOAPDomConv, Soap.Rio,
  Soap.SOAPAttachIntf, Soap.SOAPPasInv, Soap.WebNode, Soap.WSDLIntf;

type

  TLinkedWebNode = class(TComponent, IWebNode)
  private
    FInvoker: TSoapPascalInvoker;
    IntfInfo: PTypeInfo;
    FClass: TClass;
    FMimeBoundary: string;
    FWebNodeOptions: WebNodeOptions;
    FMethIntf: TIntfMethEntry;
    FStaticRequest: TBytes;
    FStaticResponse: TBytes;
  protected
    function  GetMimeBoundary: string;
    procedure SetMimeBoundary(const Value: string);

    function  GetWebNodeOptions: WebNodeOptions;
    procedure SetWebNodeOptions(Value: WebNodeOptions);

    function  GetResponseStream: TStream; virtual;
    procedure InvokeImplementation(const Request: TStream; Response: TStream);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    { IWebNode }
    procedure   BeforeExecute(const IntfMetaData: TIntfMetaData;
                              const MethodMetaData: TIntfMethEntry;
                              MethodIndex: Integer;
                              AttachHandler: IMimeAttachmentHandler); virtual;
    procedure   Execute(const DataMsg: String; Resp: TStream); overload; virtual;
    procedure   Execute(const Request: TStream; Response: TStream); overload; virtual;
    function    Execute(const Request: TStream): TStream; overload;

  published
    property Invoker: TSoapPascalInvoker read FInvoker;
    property StaticRequest: TBytes read FStaticRequest write FStaticRequest;
    property StaticResponse: TBytes read FStaticResponse write FStaticResponse;
    property MimeBoundary: string read GetMimeBoundary write SetMimeBoundary;
  end;

  TLogLinkedWebNode = class(TLinkedWebNode)
  private
    FReqFile: string;
    FRespFile: string;
  protected
    function  GetResponseStream: TStream; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute(const Request: TStream; Response: TStream); override;
  published
    property ReqFile: string read FReqFile write FReqFile;
    property RespFile: string read FRespFile write FRespFile;
  end;

  TLinkedRIO = class(TRIO)
  private
    FLinkedWebNode: TLinkedWebNode;
    FDOMConverter:  TOPToSoapDomConvert;
    FDefaultConverter: TOPToSoapDomConvert;

    function  GetDomConverter: TOpToSoapDomConvert;
    procedure SetDomConverter(Value: TOPToSoapDomConvert);
    function  GetDefaultConverter: TOPToSoapDomConvert;
  protected
    function  GetResponseStream(BindingType: TWebServiceBindingType): TStream; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
    constructor Create(AOwner: TComponent);  overload; override;
    constructor CreateFile(AOwner: TComponent; ReqFile, RespFile: string); overload;
    destructor  Destroy; override;
    property    WebNode: TLinkedWebNode read FLinkedWebNode;
  published
    property Converter: TOPToSoapDomConvert read GetDomConverter write SetDOMConverter;
  end;

  TLinkedOPToSoapDomConvert = class(TOPToSoapDomConvert)
    FLinkedRIO: TLinkedRIO;
  public
    constructor CreateLinked(AOwner: TComponent; ALinkedRIO: TLinkedRIO);
    function  InvContextToMsg(const IntfMD: TIntfMetaData;
                              MethNum: Integer;
                              Con: TInvContext;
                              Headers: THeaderList): TStream; override;
  end;

function LoadDataFromFile(const FileName: string): TBytes;
procedure WriteDataToFile(const FileName: string; const Data: TBytes);

implementation

uses
  Soap.OPConvert, Soap.SOAPAttach, Soap.SOAPConst, Soap.WebServExp, Xml.XMLDoc;

{ TLinkedRIO }

constructor TLinkedRIO.Create(AOwner: TComponent);
begin
  FLinkedWebNode := TLinkedWebNode.Create(nil);
  FLinkedWebNode.IntfInfo :=  IntfMD.Info;
  FWebNode := FLinkedWebNode as IWebNode;
  { Converter }
  FDOMConverter := GetDefaultConverter;
  FConverter := FDOMConverter as IOPConvert;
  inherited;
end;

constructor TLinkedRIO.CreateFile(AOwner: TComponent; ReqFile, RespFile: string);
begin
  FLinkedWebNode := TLogLinkedWebNode.Create(nil);
  FLinkedWebNode.IntfInfo :=  IntfMD.Info;
  TLogLinkedWebNode(FLinkedWebNode).FReqFile := ReqFile;
  TLogLinkedWebNode(FLinkedWebNode).FRespFile := RespFile;
  FWebNode := FLinkedWebNode as IWebNode;
  { Converter }
  FDOMConverter := GetDefaultConverter;
  FConverter := FDOMConverter as IOPConvert;
  inherited Create(AOwner);
end;

destructor TLinkedRIO.Destroy;
begin
  FConverter := nil;
  FWebNode := nil;
  WebNode.Free;
  inherited;
end;

function TLinkedRIO.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := inherited QueryInterface(IID, Obj);
  FLinkedWebNode.IntfInfo := IntfMD.Info;
end;

function TLinkedRIO.GetDefaultConverter: TOPToSoapDomConvert;
begin
  if (FDefaultConverter = nil) then
  begin
    FDefaultConverter := TLinkedOPToSoapDomConvert.CreateLinked(Self, Self);
    FDefaultConverter.Name := 'Converter1';                 { do not localize }
    FDefaultConverter.SetSubComponent(True);
  end;
  Result := FDefaultConverter;
end;

function TLinkedRIO.GetDomConverter: TOpToSoapDomConvert;
begin
  if not Assigned(FDOMConverter) then
  begin
    FDOMConverter := GetDefaultConverter;
    FConverter := FDOMConverter as IOPConvert;
  end;
  Result := FDOMConverter;
end;

procedure TLinkedRIO.SetDomConverter(Value: TOPToSoapDomConvert);
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
  end;
end;

function TLinkedRIO.GetResponseStream(BindingType: TWebServiceBindingType): TStream;
begin
  Result := FLinkedWebNode.GetResponseStream;
end;

procedure TLinkedRIO.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FDomConverter) then
  begin
    FConverter := nil;
    FDomConverter := nil;
  end;
end;

{ TLinkedWebNode }

constructor TLinkedWebNode.Create(AOwner: TComponent);
begin
  inherited;
  FInvoker := TSoapPascalInvoker.Create(nil);
end;

destructor TLinkedWebNode.Destroy;
begin
  FInvoker.Free;
  inherited;
end;

function TLinkedWebNode.GetMimeBoundary: string;
begin
  Result := FMimeBoundary;
end;

procedure TlinkedWebNode.SetMimeBoundary(const Value: string);
begin
  FMimeBoundary := Value;
end;

function TlinkedWebNode.GetWebNodeOptions: WebNodeOptions;
begin
  Result := FWebNodeOptions;
end;

procedure TLinkedWebNode.InvokeImplementation(const Request: TStream;
  Response: TStream);
var
  BindingType: TWebServiceBindingType;
  XMLReq: TMemoryStream;
  AttachHandler: IMimeAttachmentHandler;
begin
  InvRegistry.GetClassFromIntfInfo(IntfInfo, FClass);
  if FClass = nil then
    raise Exception.CreateFmt(SNoClassRegistered, [IntfInfo.Name]);

  { Check what Input is expecting }
  BindingType := GetBindingType(FMethIntf, True);

  AttachHandler := nil;
  AttachHandler := GetMimeAttachmentHandler(BindingType);
  try
    { Create MIME stream if we're MIME bound }
    if (BindingType = btMIME) then
    begin
      XMLReq := TMemoryStream.Create;
      try
        FMimeBoundary := SBorlandMimeBoundary;
        AttachHandler.ProcessMultiPartForm(Request, XMLReq,
                                           FMimeBoundary, Nil,
                                           FInvoker.Converter.Attachments,
                                           FInvoker.Converter.TempDir);
        FInvoker.Invoke(FClass, IntfInfo, '', XMLReq, Response, BindingType);
      finally
        XMLReq.Free;
      end;
    end else
    begin
      FMimeBoundary := '';
      FInvoker.Invoke(FClass, IntfInfo, '', Request, Response, BindingType);
    end;
    if FInvoker.Converter.Attachments.Count > 0 then
    begin
      AttachHandler.CreateMimeStream(Response, FInvoker.Converter.Attachments);
      AttachHandler.FinalizeStream;
      FMimeBoundary := SBorlandMimeBoundary;
      Response.Position := 0;
      Response.CopyFrom(AttachHandler.GetMIMEStream, 0);
    end else
      FMimeBoundary := '';
  finally
    AttachHandler := nil;
  end;
end;

procedure TlinkedWebNode.SetWebNodeOptions(Value: WebNodeOptions);
begin
  FWebNodeOptions := Value;
end;

function TLinkedWebNode.GetResponseStream: TStream;
begin
  Result := TMemoryStream.Create;
end;

procedure TLinkedWebNode.BeforeExecute(const IntfMetaData: TIntfMetaData;
                                       const MethodMetaData: TIntfMethEntry;
                                       MethodIndex: Integer;
                                       AttachHandler: IMimeAttachmentHandler);
begin
  { Store away method's descriptor (i.e. RTTI) }
  FMethIntf := MethodMetaData;
end;

function TLinkedWebNode.Execute(const Request: TStream): TStream;
begin
  Result := TMemoryStream.Create;
  Execute(Request, Result);
end;

procedure TLinkedWebNode.Execute(const Request: TStream; Response: TStream);
var
  AResponse: TBytes;
begin
  if Length(FStaticResponse) = 0 then
    InvokeImplementation(Request, Response)
  else
  begin
    AResponse := FStaticResponse;
    Response.Position := 0;
    Response.Size := Length(AResponse);
    Response.Write(AResponse, 0, Length(AResponse));
  end;
end;

procedure TLinkedWebNode.Execute(const DataMsg: String; Resp: TStream);
var
  Stream: TMemoryStream;
  AStr: TBytes;
begin
  AStr := TEncoding.UTF8.GetBytes(DataMsg);
  Stream := TMemoryStream.Create;
  try
    Stream.SetSize(Longint(Length(AStr)));
    Stream.Write(AStr, 0, Length(AStr));
    Execute(Stream, Resp);
  finally
    Stream.Free;
  end;
end;

{ TLogLinkedWebNode }

constructor TLogLinkedWebNode.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TLogLinkedWebNode.Destroy;
begin
  inherited;
end;

function TLogLinkedWebNode.GetResponseStream: TStream;
var
  FName: String;
begin
  { By sending a Response stream base on the response file,
    we get logging automatically!! }
  FName := RespFile;
  if FName = '' then
    FName := FMethIntf.Name + '_resp.xml'; { do not localize }

  Result := TFileStream.Create(FName, fmCreate);
end;

procedure TLogLinkedWebNode.Execute(const Request: TStream; Response: TStream);
var
  LogStream: TStream;
  XMLData : String;
  StringStream : TStringStream;
  FName: String;
begin
  { Load request to file }
  { Default to method name if none specified }
  FName := ReqFile;
  if FName = '' then
    FName := FMethIntf.Name + '.xml'; { do not localize }

  StringStream := TStringStream.Create('');
  try
    StringStream.CopyFrom( Request, 0 );
    XMLData := StringStream.DataString;
    try
      // Try to get formatted data but that may fail,
      // as in the case of attachments
      XMLData := FormatXMLData(StringStream.DataString);
      StringStream.Position := 0;
      StringStream.WriteString(XMLData);
    except
      { Ignore failure to format XML data }
    end;

    LogStream := TFileStream.Create(FName, fmCreate);
    try
      LogStream.CopyFrom(StringStream, 0);
    finally
      LogStream.Free;
    end;
  finally
    StringStream.Free;
  end;

  { Pass on for processing }
  inherited;

end;

{ TLinkedOPToSoapDomConvert }

constructor TLinkedOPToSoapDomConvert.CreateLinked(AOwner: TComponent; ALinkedRIO: TLinkedRIO);
begin
  FLinkedRIO := ALinkedRIO;
  inherited Create(AOwner);
end;

function TLinkedOPToSoapDomConvert.InvContextToMsg(const IntfMD: TIntfMetaData;
  MethNum: Integer; Con: TInvContext; Headers: THeaderList): TStream;
var
  AStream: TMemoryStream;
  AResponse: TBytes;
begin
//  SysDebugEnter('TLinkedOPToSoapDomConvert.InvContextToMsg');
  AResponse := FLinkedRIO.WebNode.StaticRequest;
  if Length(AResponse) > 0 then
  begin
    AStream := TMemoryStream.Create;
    AStream.Size := Length(AResponse);
    AStream.Write(AResponse, 0, Length(AResponse));
    Result := AStream;
  end
  else
  begin
    Result := inherited;
  end;
//  SysDebugLeave('TLinkedOPToSoapDomConvert.InvContextToMsg');
end;


function LoadDataFromFile(const FileName: string): TBytes;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SetLength(Result, FileStream.Size);
    FileStream.Read(Result, 0, Length(Result));
  finally
    FileStream.Free;
  end;
end;

procedure WriteDataToFile(const FileName: string; const Data: TBytes);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    FileStream.Write(Data, 0, Length(Data))
  finally
    FileStream.Free;
  end;
end;


end.
