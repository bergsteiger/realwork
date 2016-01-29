{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{ Internet Application Runtime                                                }
{                                                                             }
{ Copyright (C) 2002 Borland Software Corporation                             }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }
unit ApacheTwoApp;

interface

uses SysUtils, Classes, HTTPD2, ApacheTwoHTTP, HTTPApp, WebBroker;

type
  { TApacheApplication }
  TApacheTwoApplication = class(TWebApplication)
  private
    procedure ApacheHandleException(Sender: TObject);
  protected
    function NewRequest(var r: request_rec): TApacheTwoRequest;
    function NewResponse(ApacheRequest: TApacheTwoRequest): TApacheTwoResponse;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialize; override;
    function ProcessRequest(var r: request_rec): Integer;
  end;

  TRegisterHooksEvent = procedure(p: Papr_pool_t);

procedure set_module(defModule: Pmodule);

var
  Handler: string; { Defaults to "projectname-handler" - all lowercase }
  ModuleName:  array [0..255] of Char; { Defaults to the DLL/SO's name }
  apache_module: module; 
  {$EXTERNALSYM apache_module}
  { Assign OnRegisterHooks to a procedure and call the ap_hook_XXXX
    procedures to register your own Apache 2.0 hooks }
  OnRegisterHooks: TRegisterHooksEvent;

implementation

uses
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  BrkrConst;

var
  default_module_ptr: Pmodule;  

procedure set_module(defModule: Pmodule);
begin
  default_module_ptr := defModule;
end;

procedure HandleServerException(E: TObject; var r: request_rec);
var
  ErrorMessage, EMsg: string;
begin
  if E is Exception then
    EMsg := Exception(E).Message
  else
    EMsg := '';
  ErrorMessage := Format(sInternalServerError, [E.ClassName, EMsg]);
  r.content_type := 'text/html';
  apr_table_set(r.headers_out, 'Content-Length', pchar(IntToStr(Length(ErrorMessage))));
//  ap_send_http_header(@r); // Not used in apache 2.0
  ap_rputs(pchar(ErrorMessage), @r);
end;

constructor TApacheTwoApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Classes.ApplicationHandleException := ApacheHandleException;
end;

destructor TApacheTwoApplication.Destroy;
begin
  Classes.ApplicationHandleException := nil;
  inherited Destroy;
end;

function DefaultHandler(r: Prequest_rec): Integer; cdecl;
var
  RequestedHandler: string;
begin
  RequestedHandler := r^.handler;
  if SameText(RequestedHandler, Handler) then
    Result := (Application as TApacheTwoApplication).ProcessRequest(r^)
  else
    Result := DECLINED;
end;

procedure RegisterHooks(p: Papr_pool_t); cdecl;
begin
  ap_hook_handler(DefaultHandler, nil, nil, APR_HOOK_MIDDLE);
  if Assigned(OnRegisterHooks) then
    OnRegisterHooks(p);
end;

procedure TApacheTwoApplication.Initialize;
begin
  { NOTE: Use the pointer and not the apache_module instance directly to
          allow another module to be set (C++Builder uses that technique) }
  FillChar(default_module_ptr^, SizeOf(default_module_ptr^), 0);
  with default_module_ptr^ do
  begin
    version := MODULE_MAGIC_NUMBER_MAJOR;
    minor_version := MODULE_MAGIC_NUMBER_MINOR;
    module_index := -1;
    name := ModuleName;
    magic := MODULE_MAGIC_COOKIE;
    register_hooks := RegisterHooks;    
  end;
end;

function TApacheTwoApplication.ProcessRequest(var r: request_rec): Integer;
var
  HTTPRequest: TApacheTwoRequest;
  HTTPResponse: TApacheTwoResponse;
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
    Result := AP_OK;
  end;
end;

procedure TApacheTwoApplication.ApacheHandleException(Sender: TObject);
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

function TApacheTwoApplication.NewRequest(var r: request_rec): TApacheTwoRequest;
begin
  Result := TApacheTwoRequest.Create(r);
end;

function TApacheTwoApplication.NewResponse(ApacheRequest: TApacheTwoRequest): TApacheTwoResponse;
begin
  Result := TApacheTwoResponse.Create(ApacheRequest);
end;

procedure InitApplication;
var
  TempModuleName: string;
begin
  set_module(@apache_module);
  Application := TApacheTwoApplication.Create(nil);
  SetLength(TempModuleName, MAX_PATH+1);
  SetLength(TempModuleName, GetModuleFileName(HInstance,
    PChar(TempModuleName), Length(TempModuleName)));
  TempModuleName := LowerCase(ExtractFileName(TempModuleName));
  Handler := Lowercase(ChangeFileExt(TempModuleName, '-handler')); {do not localize}
  StrLCopy(ModuleName, PChar(TempModuleName), SizeOf(ModuleName) - 1);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Internet\ApacheTwoApp.pas initialization enter'); {$EndIf}
  InitApplication;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Internet\ApacheTwoApp.pas initialization leave'); {$EndIf}
end.
