{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Web.HTTPD24Impl;

// Implement the HTTPD interface for version 2.4
interface

uses Web.HTTPD24;

procedure RegisterHTTPD24;

type
  TApacheModuleData = record
    FBytes: array [0..sizeof(module)] of Byte;
  end;

implementation

uses Web.HTTPDMethods, Web.HTTPDImpl, System.SysUtils,
  Web.WebBroker,
  System.Math, System.Classes;

type

  THTTPMethods24 = class(TCommonHTTPDMethods)
  private
  public
    constructor Create;
    procedure InitModule; override; //(const AProcessRequest: TProcessHTTPDRequest); override;

    function server_root_relative(const ARequestRec: PHTTPDRequest; const AURI: UTF8String): UTF8String; override;
    procedure hook_handler(const AHandler: THTTPDMethods.THandlerProc; const APre: PPChar; const ASucc: PPChar; AOrder: Integer); override;
    procedure hook_child_init(const AInitiation: THTTPDMethods.TInitiationProc; const APre: PPChar; const ASucc: PPChar; AOrder: Integer); override;
    procedure pool_cleanup_register(const p: PHTTPDPool; const data: Pointer; APlainTermination: THTTPDMethods.TTerminationFunc; AChildTermination: THTTPDMethods.TTerminationFunc); override;

    function get_handler(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_method(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_ContentType(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_protocol(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_unparsed_uri(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_args(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_path_info(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_filename(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in(const ARequestRec: PHTTPDRequest; const AKey: UTF8String): UTF8String; override;
    function get_hostname(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_content_encoding(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_client_block(const ARequestRec: PHTTPDRequest; Buffer: PByte; Count: Integer): Integer; override;
    function get_ServerPort(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_Content(const ARequestRec: PHTTPDRequest): TBytes; override;
    function get_connection_ClientIP(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_connection_RemoteHost(const ARequestRec: PHTTPDRequest): UTF8String; override;

    procedure set_status(const ARequestRec: PHTTPDRequest; ACode: Integer); override;
    procedure set_headers_out(const ARequestRec: PHTTPDRequest; const Key, Value: UTF8String); override;
    procedure set_headers_out_ContentType(const ARequestRec: PHTTPDRequest; const AType: UTF8String); override;
    procedure set_headers_out_ContentEncoding(const ARequestRec: PHTTPDRequest; const AValue: UTF8String); override;
    procedure set_ContentType(const ARequestRec: PHTTPDRequest; const AValue: UTF8String); override;
    function write_buffer(const ARequestRec: PHTTPDRequest; var Buffer; Count: Integer): Integer; override;
    function write_string(const ARequestRec: PHTTPDRequest; const AValue: UTF8String): Integer; override;
  end;

// Callback from apache
procedure RegisterHooks(p: Papr_pool_t); cdecl;
begin
  Assert(Assigned(THTTPDInit.RegisterHooksProc)); // Need this to respond to requests
  if Assigned(THTTPDInit.RegisterHooksProc) then
    THTTPDInit.RegisterHooksProc(p);
end;

{ THTTPMethods24 }

procedure THTTPMethods24.InitModule;
var
  LModule: PModule;
begin
//  GProcessRequest := AProcessRequest;
  { NOTE: Use the pointer and not the apache_module instance directly to
          allow another module to be set (C++Builder uses that technique) }
  Assert(THTTPDInit.ModuleData <> nil);
  LModule := PModule(THTTPDInit.ModuleData);
  Assert(LModule <> nil);
  FillChar(LModule^, SizeOf(LModule^), 0);
  with LModule^ do
  begin
    version := MODULE_MAGIC_NUMBER_MAJOR;
    minor_version := MODULE_MAGIC_NUMBER_MINOR;
    module_index := -1;
    Assert(THTTPDInit.ModuleName <> '');
    name := THTTPDInit.ModuleName;
    magic := MODULE_MAGIC_COOKIE;
    register_hooks := RegisterHooks;
  end;
end;

constructor THTTPMethods24.Create;
begin
  // Verify that methods return values are the same as HTTPD constant values.
  Assert(get_AP_DECLINED = AP_DECLINED);
  Assert(get_AP_OK = AP_OK);
  Assert(get_AP_DONE = AP_DONE);
  Assert(get_APR_HOOK_REALLY_FIRST = APR_HOOK_REALLY_FIRST);
  Assert(get_APR_HOOK_FIRST = APR_HOOK_FIRST);
  Assert(get_APR_HOOK_MIDDLE = APR_HOOK_MIDDLE);
  Assert(get_APR_HOOK_LAST = APR_HOOK_LAST);
  Assert(get_APR_HOOK_REALLY_LAST = APR_HOOK_REALLY_LAST);
end;

function THTTPMethods24.server_root_relative(const ARequestRec: PHTTPDRequest;
  const AURI: UTF8String): UTF8String;
begin
  Result := ap_server_root_relative(Prequest_rec(ARequestRec)^.pool, PUTF8Char(AURI));
end;

function THTTPMethods24.get_args(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.args
end;

function THTTPMethods24.get_connection_ClientIP(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.connection.client_ip;
end;

function THTTPMethods24.get_connection_RemoteHost(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := ap_get_remote_host(Prequest_rec(ARequestRec)^.connection,
    Prequest_rec(ARequestRec)^.per_dir_config, REMOTE_HOST, nil);
end;

function THTTPMethods24.get_Content(
  const ARequestRec: PHTTPDRequest): TBytes;
const
  cMaxChunkSize = 1024 * 10;
var
  LBytesRead: Integer;
  LContent: TBytes;
  LBuf: PByte;
  LLen: Integer;
  LContentLength: Integer;
begin
  ap_setup_client_block(Prequest_rec(ARequestRec), REQUEST_CHUNKED_DECHUNK);
  if ap_should_client_block(Prequest_rec(ARequestRec)) = 1 then
  begin
    LBytesRead := 0;
    LContentLength := StrToInt(string(get_headers_in_ContentLength(ARequestRec)));
    SetLength(LContent, LContentLength);
    LBuf := PByte(LContent);
    while LBytesRead < LContentLength do
    begin
      LLen := ap_get_client_block(Prequest_rec(ARequestRec), LBuf,
        Min(cMaxChunkSize, LContentLength - LBytesRead));
      if LLen = 0 then
        break;
      Inc(LBytesRead, LLen);
      Inc(LBuf, LLen);
    end;
    SetLength(LContent, LBytesRead);
  end;
  Result := LContent;
end;

function THTTPMethods24.get_client_block(const ARequestRec: PHTTPDRequest; Buffer: PByte; Count: Integer): Integer;
const
  cMaxChunkSize = 1024 * 10;
var
  LBytesRead: Integer;
  LLen: Integer;
begin
  LBytesRead := 0;
  ap_setup_client_block(Prequest_rec(ARequestRec), REQUEST_CHUNKED_DECHUNK);
  if ap_should_client_block(Prequest_rec(ARequestRec)) = 1 then
  begin
    while LBytesRead < Count do
    begin
      LLen := ap_get_client_block(Prequest_rec(ARequestRec), Buffer + LBytesRead,
        Min(cMaxChunkSize, Count - LBytesRead));
      if LLen = 0 then
        break;
      Inc(LBytesRead, LLen);
    end;
  end;
  Result := LBytesRead;
end;

function THTTPMethods24.get_ContentType(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.content_type
end;

function THTTPMethods24.get_content_encoding(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.content_encoding
end;

function THTTPMethods24.get_filename(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.filename
end;

function THTTPMethods24.get_handler(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.handler
end;

function THTTPMethods24.get_headers_in(
  const ARequestRec: PHTTPDRequest; const AKey: UTF8String): UTF8String;
begin
  Result := apr_table_get(Prequest_rec(ARequestRec)^.headers_in, PUTF8Char(AKey));
end;

function THTTPMethods24.get_hostname(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.hostname
end;

function THTTPMethods24.get_method(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.method
end;

function THTTPMethods24.get_path_info(
  const ARequestRec: PHTTPDRequest): UTF8String;
var
  LSPlit:  TStrings;
  I, IStart: Integer;
begin
  LSplit := TStringList.Create;
  try
    LSplit.Delimiter := '/';
    LSplit.StrictDelimiter := True;
    LSplit.DelimitedText := string(Prequest_rec(ARequestRec)^.parsed_uri.path);

    if LSplit.DelimitedText.StartsWith('/') then
      IStart := 2
    else
      IStart := 1;

    for I := IStart to LSplit.Count-1 do
      Result := Result + '/' + UTF8String(LSplit[I]);
  finally
    LSplit.Free;
  end;
end;

function THTTPMethods24.get_protocol(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.protocol
end;

function THTTPMethods24.get_ServerPort(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := UTF8String(IntToStr(ap_get_server_port(Prequest_rec(ARequestRec))));
end;


function THTTPMethods24.get_unparsed_uri(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := Prequest_rec(ARequestRec)^.unparsed_uri
end;

procedure THTTPMethods24.hook_handler(const AHandler: THTTPDMethods.THandlerProc;
  const APre, ASucc: PPChar; AOrder: Integer);
begin
  ap_hook_handler(ap_hook_handler_t(AHandler), APre, ASucc, AOrder);
end;

procedure THTTPMethods24.hook_child_init(const AInitiation: THTTPDMethods.TInitiationProc;
  const APre, ASucc: PPChar; AOrder: Integer);
begin
  ap_hook_child_init(ap_hook_child_init_t(AInitiation), APre, ASucc, AOrder);
end;

procedure THTTPMethods24.pool_cleanup_register(const p: PHTTPDPool;
  const data: Pointer; APlainTermination,
  AChildTermination: THTTPDMethods.TTerminationFunc);
begin
    apr_pool_cleanup_register(p, data, APlainTermination, AChildTermination);
end;


procedure THTTPMethods24.set_ContentType(const ARequestRec: PHTTPDRequest;
  const AValue: UTF8String);
begin
  Prequest_rec(ARequestRec)^.content_type := 'text/html';
end;

procedure THTTPMethods24.set_headers_out(const ARequestRec: PHTTPDRequest;
  const Key, Value: UTF8String);
begin
                                      
  apr_table_set(Prequest_rec(ARequestRec)^.headers_out, PUTF8Char(Key),
    apr_pstrdup(Prequest_rec(ARequestRec)^.pool, PUTF8Char(Value)));
end;

procedure THTTPMethods24.set_headers_out_ContentEncoding(
  const ARequestRec: PHTTPDRequest; const AValue: UTF8String);
begin
  Prequest_rec(ARequestRec)^.content_encoding := apr_pstrdup(Prequest_rec(ARequestRec)^.pool, PUTF8Char(AValue));
end;

procedure THTTPMethods24.set_headers_out_ContentType(
  const ARequestRec: PHTTPDRequest; const AType: UTF8String);
begin
  Prequest_rec(ARequestRec)^.content_type := apr_pstrdup(Prequest_rec(ARequestRec)^.pool, PUTF8Char(AType));
end;

procedure THTTPMethods24.set_status(const ARequestRec: PHTTPDRequest;
  ACode: Integer);
begin
  Prequest_rec(ARequestRec)^.status := ACode;
end;

function THTTPMethods24.write_buffer(const ARequestRec: PHTTPDRequest;
  var Buffer; Count: Integer): Integer;
begin
  if Count > 0 then
    Result := ap_rwrite(Buffer, Count, Prequest_rec(ARequestRec))
  else
    Result := 0;
end;

function THTTPMethods24.write_string(const ARequestRec: PHTTPDRequest;
  const AValue: UTF8String): Integer;
var
  S: UTF8String;
begin
  if Length(AValue) > 0 then
  begin
    S := AValue;
    Result := ap_rwrite(S[1], Length(S), Prequest_rec(ARequestRec))
  end
  else
    Result := 0;
end;

procedure RegisterHTTPD24;
begin
  RegisterHTTPD(THTTPMethods24.Create);
end;

initialization
  RegisterHTTPD24;


end.
