{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{  ISAPI/NSAPI Web server application components        }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$DENYPACKAGEUNIT}

unit Web.Win.ISAPIApp;

interface

uses Winapi.Windows, System.SyncObjs, System.Classes, Web.HTTPApp, Web.WebBroker, Web.Win.IsapiHTTP, Winapi.Isapi2;

type
  TISAPIFactory = class;

  TISAPITerminateProc = procedure;

  TISAPIApplication = class(TWebApplication)
  private
    FFactory: TISAPIFactory;
    FTerminateProc: TISAPITerminateProc;
    function NewRequest(var AECB: TEXTENSION_CONTROL_BLOCK): TISAPIRequest;
    function NewResponse(ISAPIRequest: TISAPIRequest): TISAPIResponse;
    procedure ISAPIHandleException(Sender: TObject);
  public
    // These are the entry points relayed from the ISAPI DLL imports
    function GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL;
    function HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD;
    function TerminateExtension(dwFlags: DWORD): BOOL;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnTerminate: TISAPITerminateProc read FTerminateProc write FTerminateProc;
  end;

  TISAPIFactory = class(TObject)
  protected
    function NewRequest(var AECB: TEXTENSION_CONTROL_BLOCK): TISAPIRequest; virtual;
    function NewResponse(ISAPIRequest: TISAPIRequest): TISAPIResponse; virtual;
  public
    constructor Create;
  end;

function GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL; stdcall;
function HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD; stdcall;
function TerminateExtension(dwFlags: DWORD): BOOL; stdcall;

var
  DispatchThread: function (AECB: PEXTENSION_CONTROL_BLOCK): Boolean of object;

implementation

uses System.SysUtils, Web.BrkrConst;

{ TISAPIApplication }

procedure HandleServerException(E: TObject; var ECB: TEXTENSION_CONTROL_BLOCK);
var
  ResultText, ResultHeaders: string;
  Size: DWORD;
  EMsg: string;
begin
  ECB.dwHTTPStatusCode := 500;
  if E is Exception then
    EMsg := Exception(E).Message
  else
    EMsg := '';
  ResultText := Format(sInternalServerError, [E.ClassName, EMsg]);
  ResultHeaders := Format(
    'Content-Type: text/html'#13#10 +     { do not localize }
    'Content-Length: %d'#13#10#13#10,      { do not localize }
    [Length(ResultText)]); 
  ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_RESPONSE_HEADER,
    PChar('500 ' + EMsg), @Size, LPDWORD(ResultHeaders));
  Size := Length(ResultText);
  ECB.WriteClient(ECB.ConnID, Pointer(ResultText), Size, 0);
end;

function TISAPIApplication.GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL;
begin
  try
    Ver.dwExtensionVersion := MakeLong(HSE_VERSION_MINOR, HSE_VERSION_MAJOR);
    StrLCopy(Ver.lpszExtensionDesc, PAnsiChar(AnsiString(Title)), HSE_MAX_EXT_DLL_NAME_LEN);
    Integer(Result) := 1; // This is so that the Apache web server will know what "True" really is
  except
    Result := False;
  end;
end;

function TISAPIApplication.HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD;
var
  HTTPRequest: TISAPIRequest;
  HTTPResponse: TISAPIResponse;
begin
  try
    HTTPRequest := NewRequest(ECB);
    try
      HTTPResponse := NewResponse(HTTPRequest);
      try
        if HandleRequest(HTTPRequest, HTTPResponse) then
          Result := HSE_STATUS_SUCCESS
        else Result := HSE_STATUS_ERROR;
      finally
        HTTPResponse.Free;
      end;
    finally
      HTTPRequest.Free;
    end;
  except
    HandleServerException(ExceptObject, ECB);
    Result := HSE_STATUS_ERROR;
  end;
end;

function TISAPIApplication.NewRequest(var AECB: TEXTENSION_CONTROL_BLOCK): TISAPIRequest;
begin
  Result := FFactory.NewRequest(AECB);
end;

function TISAPIApplication.NewResponse(ISAPIRequest: TISAPIRequest): TISAPIResponse;
begin
  Result := FFactory.NewResponse(ISAPIRequest);
end;

function TISAPIApplication.TerminateExtension(dwFlags: DWORD): BOOL;
begin
  if Assigned(FTerminateProc) then
    FTerminateProc;
  Integer(Result) := 1; // This is so that the Apache web server will know what "True" really is
end;

// ISAPI interface

function GetExtensionVersion(var Ver: THSE_VERSION_INFO): BOOL;
begin
  Result := (Application as TISAPIApplication).GetExtensionVersion(Ver);
end;

function HttpExtensionProc(var ECB: TEXTENSION_CONTROL_BLOCK): DWORD;
begin
  if Assigned(DispatchThread) then 
  begin
    if DispatchThread(@ECB) then
      Result := HSE_STATUS_PENDING
    else
      Result := HSE_STATUS_ERROR;
  end
  else
    Result := (Application as TISAPIApplication).HttpExtensionProc(ECB);
end;

function TerminateExtension(dwFlags: DWORD): BOOL;
begin
  Result := (Application as TISAPIApplication).TerminateExtension(dwFlags);
end;

procedure InitApplication;
begin
  Application := TISAPIApplication.Create(nil);
end;
                      
procedure TISAPIApplication.ISAPIHandleException(Sender: TObject);
var
  Handled: Boolean;
  Intf: IWebExceptionHandler;
  E: TObject;
begin
  Handled := False;
  if (ExceptObject is Exception) and
      Supports(Sender, IWebExceptionHandler, Intf) then
    Intf.HandleException(Exception(ExceptObject), Handled);
  if not Handled then
  begin
    E := ExceptObject;
    AcquireExceptionObject;
    raise E;
  end;
end;

function GetISAPIFileName: string;
begin
  Result := GetModuleName(hInstance);
  // UNC issue in Vista.
  if Pos('\\?\', Result) = 1 then
    Delete(Result, 1, 4);
end;

constructor TISAPIApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Must set application name to the ISAPI dll, otherwise exe name will be used (w3wp.exe)
  Web.HTTPApp.FWebApplicationFileName := GetISAPIFileName;
  FFactory := TISAPIFactory.Create;
  System.Classes.ApplicationHandleException := ISAPIHandleException;
end;

destructor TISAPIApplication.Destroy;
begin
  if Assigned(FFactory) then
    FreeAndNil(FFactory);
  inherited Destroy;
end;

{ TISAPIFactory }

constructor TISAPIFactory.Create;
begin
  inherited;
end;

function TISAPIFactory.NewRequest(var AECB: TEXTENSION_CONTROL_BLOCK): TISAPIRequest;
begin
  Result := TISAPIRequest.Create(@AECB);
end;

function TISAPIFactory.NewResponse(ISAPIRequest: TISAPIRequest): TISAPIResponse;
begin
  Result := TISAPIResponse.Create(ISAPIRequest);
end;

initialization
  InitApplication;
end.
