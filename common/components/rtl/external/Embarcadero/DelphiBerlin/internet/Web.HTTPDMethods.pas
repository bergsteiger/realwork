{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Web.HTTPDMethods;

// Define methods for accessing apache server.
// These methods can be use for different versions of Apache 2.0.

interface

uses
  System.SysUtils;

type
  // Pointer to pool
  PHTTPDPool = type Pointer;
  // Pointer to request
  PHTTPDRequest = type Pointer;
  // Pointer to server record
  PHTTPDServer_rec = type Pointer;

  THTTPDMethods = class
  public type
    THandlerProc = function(const p: PHTTPDRequest): Integer; cdecl;
    TInitiationProc = Procedure(const p: PHTTPDPool; const s: PHTTPDServer_rec); cdecl;
    TTerminationFunc = function(const p: Pointer): Integer; cdecl;
  public
    // Consts
    class function get_AP_OK: Integer;
    class function get_AP_DONE: Integer;
    class function get_AP_DECLINED: Integer;
    class function get_APR_HOOK_REALLY_FIRST: Integer;   // May pass to hook_handler
    class function get_APR_HOOK_FIRST: Integer;
    class function get_APR_HOOK_MIDDLE: Integer;
    class function get_APR_HOOK_LAST: Integer;
    class function get_APR_HOOK_REALLY_LAST: Integer;
    // Utils
    class procedure hook_handler(const AHandler: THandlerProc; const APre: PPChar; const ASucc: PPChar; AOrder: Integer);
    class procedure hook_child_init(const AInitiation: TInitiationProc; const APre: PPChar; const ASucc: PPChar; AOrder: Integer);
    class procedure pool_cleanup_register(const p: PHTTPDPool; const data: Pointer; APlainTermination: TTerminationFunc; AChildTermination: TTerminationFunc);
    class function server_root_relative(const ARequestRec: PHTTPDRequest; const AURI: UTF8String): UTF8String;
    // Read request
    class function get_handler(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_method(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_ContentType(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_protocol(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_unparsed_uri(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_args(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_path_info(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_filename(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_Accept(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_From(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_hostname(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_Referer(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_UserAgent(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_content_encoding(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_ContentType(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_ContentLength(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_Title(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_ServerPort(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_Content(const ARequestRec: PHTTPDRequest): TBytes;
    class function get_client_block(const ARequestRec: PHTTPDRequest; Buffer: PByte; Count: Integer): Integer;
    class function get_Field(const ARequestRec: PHTTPDRequest; const AName: UTF8String): UTF8String;
    class function get_connection_ClientIP(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_connection_RemoteHost(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_Connection(const ARequestRec: PHTTPDRequest): UTF8String;
    class function get_headers_in_Cookie(const ARequestRec: PHTTPDRequest): UTF8String;
    /// <summary> Returns the header Authorization value </summary>
    class function get_headers_in_Authorization(const ARequestRec: PHTTPDRequest): UTF8String;
    // write request response
    class procedure set_status(const ARequestRec: PHTTPDRequest; ACode: Integer);
    class procedure set_headers_out(const ARequestRec: PHTTPDRequest; const Key, Value: UTF8String);
    class procedure set_headers_out_ContentType(const ARequestRec: PHTTPDRequest; const AType: UTF8String);
    class procedure set_headers_out_ContentEncoding(const ARequestRec: PHTTPDRequest; const AValue: UTF8String);
    class procedure set_ContentType(const ARequestRec: PHTTPDRequest; const AValue: UTF8String);
    class procedure set_headers_out_ContentLength(const ARequestRec: PHTTPDRequest; AValue: Integer);
    class procedure set_location(const ARequestRec: PHTTPDRequest; const AValue: UTF8String);  // redirect
    class function write_buffer(const ARequestRec: PHTTPDRequest; var Buffer; Count: Integer): Integer;
    class function write_string(const ARequestRec: PHTTPDRequest; const AValue: UTF8String): Integer;
  end;

  EHTTPMethodsError = class(Exception);

  THTTPDInit = class
  public type
    TRegisterHooksProc = procedure(const p: PHTTPDPool);
    TModuleData = pbyte;
  private
    class var FRegisterHooksProc: TRegisterHooksProc;
    class var FModuleData: TModuleData;
    class var FHandlerName: UTF8String;
    class var FModuleName: UTF8String;
    class var FRegisterCustomHooksProc: TRegisterHooksProc;
    class function GetModuleName: PUTF8Char; static; // Defaults to the DLL/SO's name
  public
    class procedure  InitModule(const ARegisterHooksProc: TRegisterHooksProc;
        const AModuleData: TModuleData; const AHandlerName: UTF8String);
    class property RegisterHooksProc: TRegisterHooksProc read FRegisterHooksProc;
    class property RegisterCustomHooksProc: TRegisterHooksProc read FRegisterCustomHooksProc write FRegisterCustomHooksProc;
    class property ModuleData: TModuleData read FModuleData;
    class property HandlerName: UTF8String read FHandlerName;
    class property ModuleName: PUTF8Char read GetModuleName;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  Web.HTTPDImpl, Web.ApacheConst, System.Math;

procedure CheckRegister; inline;
begin
  if GHTTPDImpl = nil then
    raise EHTTPMethodsError.CreateRes(@sHTTPDImplNotRegistered);
end;

{ TRequestRecReader }

class function THTTPDMethods.get_args(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_args(ARequestRec);
end;

class function THTTPDMethods.get_connection_ClientIP(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_connection_ClientIP(ARequestRec);
end;

class function THTTPDMethods.get_connection_RemoteHost(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_connection_RemoteHost(ARequestRec);
end;

class function THTTPDMethods.get_Content(
  const ARequestRec: PHTTPDRequest): TBytes;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_Content(ARequestRec);
end;

class function THTTPDMethods.get_client_block(const ARequestRec: PHTTPDRequest; Buffer: PByte; Count: Integer): Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_client_block(ARequestRec, Buffer, Count);
end;

class function THTTPDMethods.get_ContentType(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_ContentType(ARequestRec);
end;

class function THTTPDMethods.get_content_encoding(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_content_encoding(ARequestRec);
end;

class function THTTPDMethods.get_Field(const ARequestRec: PHTTPDRequest;
  const AName: UTF8String): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_Field(ARequestRec, AName);
end;

class function THTTPDMethods.get_filename(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_filename(ARequestRec);
end;

class function THTTPDMethods.get_handler(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_handler(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_Accept(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_Accept(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_Cookie(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_Cookie(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_Authorization(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_Authorization(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_Connection(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_Connection(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_ContentLength(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_ContentLength(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_ContentType(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_ContentType(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_From(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_From(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_Referer(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_Referer(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_Title(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_Title(ARequestRec);
end;

class function THTTPDMethods.get_headers_in_UserAgent(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_headers_in_UserAgent(ARequestRec);
end;

class function THTTPDMethods.get_hostname(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_hostname(ARequestRec);
end;

class function THTTPDMethods.get_method(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_method(ARequestRec);
end;

class function THTTPDMethods.get_path_info(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_path_info(ARequestRec);
end;

class function THTTPDMethods.get_protocol(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_protocol(ARequestRec);
end;

class function THTTPDMethods.get_ServerPort(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_ServerPort(ARequestRec);
end;

class function THTTPDMethods.get_unparsed_uri(
  const ARequestRec: PHTTPDRequest): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_unparsed_uri(ARequestRec);
end;


class procedure THTTPDMethods.hook_handler(const AHandler: THandlerProc;
  const APre, ASucc: PPChar; AOrder: Integer);
begin
  CheckRegister;
  GHTTPDImpl.hook_handler(AHandler, APre, ASucc, AOrder);
end;

class procedure THTTPDMethods.pool_cleanup_register(const p: PHTTPDPool;
  const data: Pointer; APlainTermination, AChildTermination: TTerminationFunc);
begin
  CheckRegister;
  GHTTPDImpl.pool_cleanup_register(p, data, APlainTermination, AChildTermination);
end;

class procedure THTTPDMethods.hook_child_init(const AInitiation: TInitiationProc;
  const APre, ASucc: PPChar; AOrder: Integer);
begin
  CheckRegister;
  GHTTPDImpl.hook_child_init(AInitiation, APre, ASucc, AOrder);
end;



class function THTTPDMethods.server_root_relative(
  const ARequestRec: PHTTPDRequest; const AURI: UTF8String): UTF8String;
begin
  CheckRegister;
  Result := GHTTPDImpl.server_root_relative(ARequestRec, AURI);
end;


class procedure THTTPDMethods.set_ContentType(
  const ARequestRec: PHTTPDRequest; const AValue: UTF8String);
begin
  CheckRegister;
  GHTTPDImpl.set_ContentType(ARequestRec, AValue);
end;

class procedure THTTPDMethods.set_headers_out(
  const ARequestRec: PHTTPDRequest; const Key, Value: UTF8String);
begin
  CheckRegister;
  GHTTPDImpl.set_headers_out(ARequestRec, Key, Value);
end;

class procedure THTTPDMethods.set_headers_out_ContentEncoding(
  const ARequestRec: PHTTPDRequest; const AValue: UTF8String);
begin
  CheckRegister;
  GHTTPDImpl.set_headers_out_ContentEncoding(ARequestRec, AValue);
end;

class procedure THTTPDMethods.set_headers_out_ContentLength(
  const ARequestRec: PHTTPDRequest; AValue: Integer);
begin
  CheckRegister;
  GHTTPDImpl.set_headers_out_ContentLength(ARequestRec, AValue);
end;

class procedure THTTPDMethods.set_headers_out_ContentType(
  const ARequestRec: PHTTPDRequest; const AType: UTF8String);
begin
  CheckRegister;
  GHTTPDImpl.set_headers_out_ContentType(ARequestRec, AType);
end;

class procedure THTTPDMethods.set_location(const ARequestRec: PHTTPDRequest;
  const AValue: UTF8String);
begin
  CheckRegister;
  GHTTPDImpl.set_headers_out_location(ARequestRec, AValue);
end;

class procedure THTTPDMethods.set_status(const ARequestRec: PHTTPDRequest;
  ACode: Integer);
begin
  CheckRegister;
  GHTTPDImpl.set_status(ARequestRec, ACode);
end;

class function THTTPDMethods.write_buffer(const ARequestRec: PHTTPDRequest;
  var Buffer; Count: Integer): Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.write_buffer(ARequestRec, Buffer, Count);
end;

class function THTTPDMethods.write_string(const ARequestRec: PHTTPDRequest;
  const AValue: UTF8String): Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.write_string(ARequestRec, AValue);
end;

class function THTTPDMethods.get_APR_HOOK_FIRST: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_APR_HOOK_FIRST;
end;

class function THTTPDMethods.get_APR_HOOK_LAST: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_APR_HOOK_LAST;
end;

class function THTTPDMethods.get_APR_HOOK_MIDDLE: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_APR_HOOK_MIDDLE;
end;

class function THTTPDMethods.get_APR_HOOK_REALLY_FIRST: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_APR_HOOK_REALLY_FIRST;
end;

class function THTTPDMethods.get_APR_HOOK_REALLY_LAST: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_APR_HOOK_REALLY_LAST;
end;

class function THTTPDMethods.get_AP_DECLINED: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_AP_DECLINED;
end;

class function THTTPDMethods.get_AP_DONE: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_AP_DONE;
end;

class function THTTPDMethods.get_AP_OK: Integer;
begin
  CheckRegister;
  Result := GHTTPDImpl.get_AP_OK;
end;

{ HTTPDInit }

class function THTTPDInit.GetModuleName: PUTF8Char;
begin
  Result := PUTF8Char(FModuleName);
end;

class procedure THTTPDInit.InitModule(const ARegisterHooksProc: TRegisterHooksProc;
  const AModuleData: TModuleData; const AHandlerName: UTF8String);
var
  LModuleName: string;
  LHandlerName: UTF8String;
begin
  Assert(Assigned(ARegisterHooksProc));
  Assert(AModuleData <> nil);
  CheckRegister;

  // Set global variables

  // Exract module name
  SetLength(LModuleName, MAX_PATH+1);
  SetLength(LModuleName, GetModuleFileName(HInstance,
    PChar(LModuleName), Length(LModuleName)));
  LModuleName := ExtractFileName(string(LModuleName));
  if AHandlerName <> '' then
    LHandlerName := AHandlerName
  else
  begin
     // If no handler name provided, generate one from dll name
                                                                                    
    LHandlerName := UTF8String(Lowercase(ChangeFileExt(LModuleName, '-handler'))); {do not localize}
  end;
  FModuleName := UTF8String(LowerCase(LModuleName));
  FHandlerName := LHandlerName;
  FModuleData := AModuleData;
  FRegisterHooksProc := ARegisterHooksProc;

  // Initialize module data
  GHTTPDImpl.InitModule;
end;

end.
