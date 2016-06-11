{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Web.HTTPDImpl;

interface

uses Web.HTTPDMethods, System.SysUtils;

type

  // Base class of HTTPD abstraction.  Derive from this class to support a specific Apache version.
  TAbstractHTTPDMethods = class abstract
  public
    procedure InitModule; virtual; abstract;
    // Consts
    function get_AP_OK: Integer; virtual; abstract;
    function get_AP_DONE: Integer; virtual; abstract;
    function get_AP_DECLINED: Integer; virtual; abstract;
    function get_APR_HOOK_REALLY_FIRST: Integer; virtual; abstract;
    function get_APR_HOOK_FIRST: Integer; virtual; abstract;
    function get_APR_HOOK_MIDDLE: Integer; virtual; abstract;
    function get_APR_HOOK_LAST: Integer; virtual; abstract;
    function get_APR_HOOK_REALLY_LAST: Integer; virtual; abstract;
    // Utils
    function server_root_relative(const ARequestRec: PHTTPDRequest; const AURI: UTF8String): UTF8String; virtual; abstract;
    procedure hook_handler(const AHandler: THTTPDMethods.THandlerProc; const APre: PPChar; const ASucc: PPChar; AOrder: Integer); virtual; abstract;
    procedure hook_child_init(const AInitiation: THTTPDMethods.TInitiationProc; const APre: PPChar; const ASucc: PPChar; AOrder: Integer); virtual; abstract;
    procedure pool_cleanup_register(const p: PHTTPDPool; const data: Pointer; APlainTermination: THTTPDMethods.TTerminationFunc; AChildTermination: THTTPDMethods.TTerminationFunc); virtual; abstract;

    // Read request
    function get_handler(const ARequestRect: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_method(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_ContentType(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_protocol(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_unparsed_uri(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_args(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_path_info(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_filename(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_Field(const ARequestRec: PHTTPDRequest; const AKey: UTF8String): UTF8String; virtual; abstract;
    function get_headers_in_Accept(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_From(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_hostname(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_Referer(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_UserAgent(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_content_encoding(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_ContentType(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_ContentLength(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_Title(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_ServerPort(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_client_block(const ARequestRec: PHTTPDRequest; Buffer: PByte; Count: Integer): Integer; virtual; abstract;
    function get_Content(const ARequestRec: PHTTPDRequest): TBytes; virtual; abstract;
    function get_connection_ClientIP(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_connection_RemoteHost(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_Connection(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    function get_headers_in_Cookie(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    /// <summary> Returns the header Authorization value </summary>
    function get_headers_in_Authorization(const ARequestRec: PHTTPDRequest): UTF8String; virtual; abstract;
    // write request response
    procedure set_status(const ARequestRec: PHTTPDRequest; ACode: Integer); virtual; abstract;
    procedure set_headers_out(const ARequestRec: PHTTPDRequest; const Key, Value: UTF8String); virtual; abstract;
    procedure set_headers_out_ContentType(const ARequestRec: PHTTPDRequest; const AType: UTF8String); virtual; abstract;
    procedure set_headers_out_ContentEncoding(const ARequestRec: PHTTPDRequest; const AValue: UTF8String); virtual; abstract;
    procedure set_ContentType(const ARequestRec: PHTTPDRequest; const AValue: UTF8String); virtual; abstract;
    procedure set_headers_out_ContentLength(const ARequestRec: PHTTPDRequest; AValue: Integer); virtual; abstract;
    procedure set_headers_out_Location(const ARequestRec: PHTTPDRequest; const AValue: UTF8String); virtual; abstract;
    function write_buffer(const ARequestRec: PHTTPDRequest; var Buffer; Count: Integer): Integer; virtual; abstract;
    function write_string(const ARequestRec: PHTTPDRequest; const AValue: UTF8String): Integer; virtual; abstract;
  end;

  TCommonHTTPDMethods = class abstract(TAbstractHTTPDMethods)
  public
    const
      cUserAgent = 'User-Agent';
      cContentType = 'Content-Type';
      cAccept = 'Accept';
      cCookie = 'Cookie';
      cAuthorization = 'Authorization';
      cFrom = 'From';
      cReferer = 'Referer';
      cTitle = 'Title';
      cConnection = 'Connection';
      cContentLength = 'Content-Length';
      cLocation = 'Location';
      // Typical values
      cAP_OK = 0;
      cAP_DONE = -2;
      cAP_DECLINED = -1;
      cAPR_HOOK_REALLY_FIRST = -10;
      cAPR_HOOK_FIRST = 0;
      cAPR_HOOK_MIDDLE = 10;
      cAPR_HOOK_LAST = 20;
      cAPR_HOOK_REALLY_LAST = 30;
  protected
    function get_headers_in(const ARequestRec: PHTTPDRequest; const AKey: UTF8String): UTF8String; virtual; abstract;
  public
    function get_AP_OK: Integer; override;
    function get_AP_DONE: Integer; override;
    function get_AP_DECLINED: Integer; override;
    function get_APR_HOOK_REALLY_FIRST: Integer; override;
    function get_APR_HOOK_FIRST: Integer; override;
    function get_APR_HOOK_MIDDLE: Integer; override;
    function get_APR_HOOK_LAST: Integer; override;
    function get_APR_HOOK_REALLY_LAST: Integer; override;

    function get_headers_in_Accept(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_Field(const ARequestRec: PHTTPDRequest; const AKey: UTF8String): UTF8String; override;
    function get_headers_in_Connection(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_ContentLength(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_ContentType(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_Cookie(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_Authorization(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_From(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_Referer(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_Title(const ARequestRec: PHTTPDRequest): UTF8String; override;
    function get_headers_in_UserAgent(const ARequestRec: PHTTPDRequest): UTF8String; override;

    procedure set_headers_out_ContentLength(const ARequestRec: PHTTPDRequest; AValue: Integer); override;
    procedure set_headers_out_Location(const ARequestRec: PHTTPDRequest; const AValue: UTF8String); override;
  end;

  procedure RegisterHTTPD(const AHTTPDImpl: TAbstractHTTPDMethods);

var
  GHTTPDImpl: TAbstractHTTPDMethods;

implementation

uses Web.ApacheConst;


function TCommonHTTPDMethods.get_APR_HOOK_FIRST: Integer;
begin
  Result := cAPR_HOOK_FIRST
end;

function TCommonHTTPDMethods.get_APR_HOOK_LAST: Integer;
begin
  Result := cAPR_HOOK_LAST
end;

function TCommonHTTPDMethods.get_APR_HOOK_MIDDLE: Integer;
begin
  Result := cAPR_HOOK_MIDDLE
end;

function TCommonHTTPDMethods.get_APR_HOOK_REALLY_FIRST: Integer;
begin
  Result := cAPR_HOOK_REALLY_FIRST
end;

function TCommonHTTPDMethods.get_APR_HOOK_REALLY_LAST: Integer;
begin
  Result := cAPR_HOOK_REALLY_LAST
end;

function TCommonHTTPDMethods.get_AP_DECLINED: Integer;
begin
  Result := cAP_DECLINED
end;

function TCommonHTTPDMethods.get_AP_DONE: Integer;
begin
  Result := cAP_DONE
end;

function TCommonHTTPDMethods.get_AP_OK: Integer;
begin
  Result := cAP_OK
end;

function TCommonHTTPDMethods.get_headers_in_Accept(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cAccept);
end;

function TCommonHTTPDMethods.get_headers_in_Cookie(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cCookie);
end;

function TCommonHTTPDMethods.get_headers_in_Authorization(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cAuthorization);
end;

function TCommonHTTPDMethods.get_headers_in_Connection(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cConnection);
end;

function TCommonHTTPDMethods.get_headers_in_ContentLength(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cContentLength);
end;

function TCommonHTTPDMethods.get_headers_in_ContentType(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cContentType);
end;

function TCommonHTTPDMethods.get_headers_in_Field(
  const ARequestRec: PHTTPDRequest; const AKey: UTF8String): UTF8String;
begin
  Result := get_headers_in(ARequestRec, AKey);
end;

function TCommonHTTPDMethods.get_headers_in_From(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cFrom);
end;

function TCommonHTTPDMethods.get_headers_in_Referer(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cReferer);
end;

function TCommonHTTPDMethods.get_headers_in_Title(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cTitle);
end;

function TCommonHTTPDMethods.get_headers_in_UserAgent(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  Result := get_headers_in(ARequestRec, cUserAgent);
end;

procedure TCommonHTTPDMethods.set_headers_out_ContentLength(
  const ARequestRec: PHTTPDRequest; AValue: Integer);
begin
  set_headers_out(ARequestRec, cContentLength, PUTF8Char(UTF8String(IntToStr(AValue))));
end;

procedure TCommonHTTPDMethods.set_headers_out_Location(const ARequestRec: PHTTPDRequest;
  const AValue: UTF8String);
begin
  set_headers_out(ARequestRec, cLocation, PUTF8Char(AValue));
end;

procedure RegisterHTTPD(const AHTTPDImpl: TAbstractHTTPDMethods);
begin
  if GHTTPDImpl <> nil then
  begin
    GHTTPDImpl.Free;
    raise EHTTPMethodsError.CreateRes(@sMultipleVersions);
  end;
  GHTTPDImpl := AHTTPDImpl;
end;

initialization
finalization
  FreeAndNil(GHTTPDImpl);
end.
