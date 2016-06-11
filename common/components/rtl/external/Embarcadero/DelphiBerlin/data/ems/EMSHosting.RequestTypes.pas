{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.RequestTypes;

{$SCOPEDENUMS ON}

interface

uses System.Classes, System.SysUtils, System.Generics.Collections;

type

  TEMSHostMethodType = (Put, Get, Post, Head, Delete, Patch);

  TStringKeyValue = TPair<string, string>;
  TStringKeyValues = TArray<TPair<string, string>>;

  IEMSHostRequest = interface
    function GetContentType: string;
    function GetMethodType: TEMSHostMethodType;
    function GetPathInfo: string;
    function GetQueryFields: TStringKeyValues;
    function GetRawContent: TBytes;
    function GetMethod: string;
    function GetContentLength: Integer;
    function GetHeader(const AName: string): string;
    function GetBasePath: string;
    function GetServerHost: string;
    property ContentLength: Integer read GetContentLength;
    property ContentType: string read GetContentType;
    property MethodType: TEMSHostMethodType read GetMethodType;
    property PathInfo: string read GetPathInfo;
    property QueryFields: TStringKeyValues read GetQueryFields;
    property RawContent: TBytes read GetRawContent;
    property Method: string read GetMethod;
    property Headers[const I: string]: string read GetHeader;
  end;

  IEMSHostRequestLocation = interface
    ['{819E8684-3455-4B8A-AE31-AE708132362E}']
    function MakeAbsoluteLocation(const ALocation: string): string;
  end;

  TEMSHostRequest = class abstract(TInterfacedObject, IEMSHostRequest)
  public type
    TMethodType = TEMSHostMethodType;
  protected
    function GetContentType: string; virtual; abstract;
    function GetMethodType: TMethodType; virtual; abstract;
    function GetPathInfo: string; virtual; abstract;
    function GetQueryFields: TStringKeyValues; virtual; abstract;
    function GetRawContent: TBytes; virtual; abstract;
    function GetMethod: string; virtual;
    function GetContentLength: Integer;  virtual; abstract;
    function GetHeader(const AName: string): string;  virtual; abstract;
    function GetBasePath: string; virtual; abstract;
    function GetServerHost: string; virtual; abstract;
  end;

  IEMSHostResponse = interface
    function GetContentStream: TStream;
    function GetContentType: string;
    function GetStatusCode: Integer;
    function GetReasonString: string;
    procedure SetContentStream(const Value: TStream);
    procedure SetStatusCode(const Value: Integer);
    function GetRequest: IEMSHostRequest;
    procedure SetContentType(const Value: string);
    property ContentType: string read GetContentType write SetContentType;
    property StatusCode: Integer read GetStatusCode write SetStatusCode;
    property ContentStream: TStream read GetContentStream write SetContentStream;
    property Request: IEMSHostRequest read GetRequest;
    property ReasonString: string read GetReasonString;
  end;

  IEMSHostResponseLocation = interface
    ['{4DDEEE38-32B8-44A0-9F0E-FF16E2C4A4CA}']
    procedure SetLocation(const Value: string);
    property Location: string write SetLocation;
  end;

  IEMSHostResponseHeaders = interface
    ['{7364E7ED-7C27-4319-9855-11F24ACB3A77}']
    function GetHeader(const AName: string): string;
    procedure SetHeader(const AName, AValue: string);
  end;

  TEMSHostResponse = class abstract(TInterfacedObject, IEMSHostResponse)
  protected
    function GetContentStream: TStream; virtual; abstract;
    function GetContentType: string; virtual; abstract;
    function GetStatusCode: Integer; virtual; abstract;
    procedure SetContentStream(const Value: TStream); virtual; abstract;
    procedure SetStatusCode(const Value: Integer); virtual; abstract;
    function GetRequest: IEMSHostRequest; virtual; abstract;
    procedure SetContentType(const Value: string); virtual; abstract;
    function GetReasonString: string; virtual;
  end;

  IEMSHostContext = interface

  end;

  IEMSEdgeHostContext = interface(IEMSHostContext)
    ['{4BF0A003-61EE-4196-8D6E-DBC9ACA579B3}']
    function GetModuleName: string;
    function GetModuleVersion: string;
    function GetGroupsByUser(const AUserID: string): TArray<string>;
    function UserIDOfSession(const ASessionToken: string; out AUserID: string): Boolean;
    function UserNameOfID(const AUserID: string; out AUserName: string): Boolean;
    property ModuleName: string read GetModuleName;
    property ModuleVersion: string read GetModuleVersion;
  end;

  TEMSEdgeHostContext = class(TInterfacedObject, IEMSHostContext, IEMSEdgeHostContext)
  protected
    function GetModuleName: string; virtual; abstract;
    function GetModuleVersion: string; virtual; abstract;
    function GetGroupsByUser(const AUserID: string): TArray<string>; virtual; abstract;
    function UserIDOfSession(const ASessionID: string; out AUserID: string): Boolean; virtual; abstract;
    function UserNameOfID(const AUserID: string; out AUserName: string): Boolean; virtual; abstract;
  end;


implementation


{ TEMSHostRequest }

function TEMSHostRequest.GetMethod: string;
begin
  case GetMethodType of
    TEMSHostMethodType.Put: Result := 'PUT';  // do not localize
    TEMSHostMethodType.Get: Result := 'GET';  // do not localize
    TEMSHostMethodType.Post: Result := 'POST';  // do not localize
    TEMSHostMethodType.Head: Result := 'HEAD';     // do not localize
    TEMSHostMethodType.Delete: Result := 'DELETE';  // do not localize
    TEMSHostMethodType.Patch: Result := 'PATCH';  // do not localize
  else
    Assert(False); // unexpected case
  end;
end;

{ TEMSHostResponse }

function TEMSHostResponse.GetReasonString: string;
begin
  if GetStatusCode >= 300 then
    Result := 'Error' // do not localize
  else
    Result := 'OK';  // do not localize
end;

end.
