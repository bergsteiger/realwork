{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

{$WARN IMPLICIT_STRING_CAST OFF}

unit Web.ApacheApp;

interface

uses System.SysUtils, System.Classes, Web.ApacheHTTP, Web.HTTPDMethods, Web.HTTPApp, Web.WebBroker;

type
  TApacheTerminateProc = procedure;

  { TApacheApplication }
  TApacheApplication = class(TWebApplication)
  private
    FTerminateProc: TApacheTerminateProc;
    procedure ApacheHandleException(Sender: TObject);
  protected
    function NewRequest(const r: PHTTPDRequest): TApacheRequest;
    function NewResponse(ApacheRequest: TApacheRequest): TApacheResponse;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ProcessRequest(const r: PHTTPDRequest): Integer;
    function TerminateExtension(): integer;
    property OnTerminate: TApacheTerminateProc read FTerminateProc write FTerminateProc;
  end;

procedure InitApplication(const AModuleData: Pointer; const AHandlerName: UTF8String = '');

implementation

uses
  Web.BrkrConst;

procedure HandleServerException(E: TObject; const r: PHTTPDRequest);
var
  ErrorMessage, EMsg: string;
begin
  if E is Exception then
    EMsg := Exception(E).Message
  else
    EMsg := '';
  ErrorMessage := Format(sInternalServerError, [E.ClassName, EMsg]);
  THTTPDMethods.set_ContentType(r, 'text/html'); //r.content_type := 'text/html';
  THTTPDMethods.set_headers_out_ContentLength(r, Length(ErrorMessage));
  THTTPDMethods.write_string(r, UTF8String(ErrorMessage));
end;

function GetModuleFileName: string;
begin
  Result := GetModuleName(hInstance);
  // UNC issue in Vista.
  if Result.IndexOf('\\?\') = 0 then
    Result := Result.Substring(4);
end;

constructor TApacheApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Web.HTTPApp.FWebApplicationFileName := GetModuleFileName;
  System.Classes.ApplicationHandleException := ApacheHandleException;
end;

destructor TApacheApplication.Destroy;
begin
  System.Classes.ApplicationHandleException := nil;
  inherited Destroy;
end;

function TApacheApplication.ProcessRequest(const r: PHTTPDRequest): Integer;
var
  HTTPRequest: TApacheRequest;
  HTTPResponse: TApacheResponse;
begin
  try
    HTTPRequest := NewRequest(r);
    try
      HTTPResponse := NewResponse(HTTPRequest);
      try
        HandleRequest(HTTPRequest, HTTPResponse);
        Result := HTTPResponse.ReturnCode;  { Typically will be AP_OK }
      finally
        HTTPResponse.Free;
      end;
    finally
      HTTPRequest.Free;
    end;
  except
    HandleServerException(ExceptObject, r);
    { NOTE: Tell Apache we've handled this request; so there's no need to
            pass this on to other modules. }
    Result := THTTPDMethods.get_AP_OK; //  AP_OKx;
  end;
end;

function TApacheApplication.TerminateExtension(): integer;
begin
  if Assigned(FTerminateProc) then
    FTerminateProc;
    Result:= THTTPDMethods.get_AP_OK;
  end;

procedure TApacheApplication.ApacheHandleException(Sender: TObject);
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

function TApacheApplication.NewRequest(const r: PHTTPDRequest): TApacheRequest;
begin
  Result := TApacheRequest.Create(r);
end;

function TApacheApplication.NewResponse(ApacheRequest: TApacheRequest): TApacheResponse;
begin
  Result := TApacheResponse.Create(ApacheRequest);
end;

// Handle apache request
function DefaultHandler(const r: PHTTPDRequest): Integer; cdecl;
var
  RequestedHandler: UTF8String;
begin
  RequestedHandler := THTTPDMethods.get_handler(r); // r^.handler;
  if (Application is TApacheApplication) and SameText(string(RequestedHandler), string(THTTPDInit.HandlerName)) then
    Result := TApacheApplication(Application).ProcessRequest(r)
  else
    Result := THTTPDMethods.get_AP_DECLINED; //  DECLINEDx;
end;

// Handle apache Termination
function TerminationHandler(const p: Pointer): Integer; cdecl;
begin
    Result := TApacheApplication(Application).TerminateExtension;
    //Result := THTTPDMethods.get_AP_OK;
end;

// Handle apache Initiation
procedure InitiationHandler(const p: PHTTPDPool; const s: PHTTPDServer_rec); cdecl;
begin
  //register a cleanup function for when apache terminates the module.
  THTTPDMethods.pool_cleanup_register(p, nil, TerminationHandler, nil);
end;


procedure DoRegisterHooks(const p: PHTTPDPool);
begin
  THTTPDMethods.hook_handler(DefaultHandler, nil, nil, THTTPDMethods.get_APR_HOOK_MIDDLE);
  THTTPDMethods.hook_child_init(InitiationHandler, nil, nil, THTTPDMethods.get_APR_HOOK_MIDDLE);
  if Assigned(THTTPDInit.RegisterCustomHooksProc) then
  begin
    // Allow application to register custom hooks
    THTTPDInit.RegisterCustomHooksProc(p);
  end;
end;

procedure InitApplication(const AModuleData: Pointer; const AHandlerName: UTF8String);
begin
  // Initialize internal data structures
  THTTPDInit.InitModule(DoRegisterHooks, PByte(AModuleData), AHandlerName);
  Application := TApacheApplication.Create(nil);
end;

end.
