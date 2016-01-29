{*******************************************************}
{                                                       }
{ Borland Delphi Visual Component Library               }
{                SOAP Support                           }
{                                                       }
{ Copyright (c) 2001 Borland Software Corporation       }
{                                                       }
{*******************************************************}

unit SOAPLinked;

interface

uses Classes, Rio, TypInfo, WebNode, SOAPPasInv, IntfInfo, WSDLIntf,
     SOAPAttachIntf;

type

  TLinkedWebNode = class(TComponent, IWebNode)
  private
    FInvoker: TSoapPascalInvoker;
    IntfInfo: PTypeInfo;
    FClass: TClass;
    FMimeBoundary: string;
    FMethIntf: TIntfMethEntry;
  protected
    function  GetMimeBoundary: string;
    procedure SetMimeBoundary(Value: string);
    function  GetResponseStream: TStream; virtual;
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
    function Execute(const Request: TStream): TStream; overload;
    property Invoker: TSoapPascalInvoker read FInvoker;
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
  protected
    function  GetResponseStream(BindingType: TWebServiceBindingType): TStream; override;
  public
    function QueryInterface(const IID: TGUID; out Obj): HResult; override; stdcall;
    constructor Create(AOwner: TComponent);  overload; override;
    constructor CreateFile(AOwner: TComponent; ReqFile, RespFile: string); overload;
    destructor  Destroy; override;
    property    WebNode: TLinkedWebNode read FLinkedWebNode;
  end;


implementation

uses SysUtils, OPConvert, OPToSOAPDomConv, InvokeRegistry,
     SOAPConst, WebServExp, SOAPAttach;

{ TLinkedRIO }

constructor TLinkedRIO.Create(AOwner: TComponent);
begin
  FLinkedWebNode := TLinkedWebNode.Create(nil);
  FLinkedWebNode.IntfInfo :=  IntfMD.Info;
  FWebNode := FLinkedWebNode as IWebNode;
  FConverter := TOPToSoapDomConvert.Create(nil) as IOpConvert;
  inherited;
end;

constructor TLinkedRIO.CreateFile(AOwner: TComponent; ReqFile,
  RespFile: string);
begin
  FLinkedWebNode := TLogLinkedWebNode.Create(nil);
  FLinkedWebNode.IntfInfo :=  IntfMD.Info;
  TLogLinkedWebNode(FLinkedWebNode).FReqFile := ReqFile;
  TLogLinkedWebNode(FLinkedWebNode).FRespFile := RespFile;
  FWebNode := FLinkedWebNode as IWebNode;
  FConverter := TOPToSoapDomConvert.Create(nil) as IOpConvert;
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

function TLinkedRIO.GetResponseStream(BindingType: TWebServiceBindingType): TStream;
begin
  Result := FLinkedWebNode.GetResponseStream;
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

procedure TlinkedWebNode.SetMimeBoundary(Value: string);
begin
  FMimeBoundary := Value;
end;

function  TLinkedWebNode.GetResponseStream: TStream;
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

procedure TLinkedWebNode.Execute(const DataMsg: String; Resp: TStream);
var
 Stream: TStream;
 S: string;
begin
  Stream := TMemoryStream.Create;
  try
    S := UTF8Encode(DataMsg);
    S := DataMsg;
    Stream.WriteBuffer(S[1], Length(S));
    Stream.Position := 0;
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
    we get  logging automatically!! }
  FName := RespFile;
  if FName = '' then
    FName := FMethIntf.Name + '_resp.xml'; { do not localize }

  Result := TFileStream.Create(FName, fmCreate);
end;

procedure TLogLinkedWebNode.Execute(const Request: TStream; Response: TStream);
var
  LogStream: TStream;
  FName: String;
begin
  { Load request to file }
  { Default to method name if none specified }
  FName := ReqFile;
  if FName = '' then
    FName := FMethIntf.Name + '.xml'; { do not localize }

  LogStream := TFileStream.Create(FName, fmCreate);
  try
    LogStream.CopyFrom(Request, 0);
  finally
    LogStream.Free;
  end;

  { Pass on for processing }
  inherited;

end;

end.
