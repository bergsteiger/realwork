{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                  UDDI Browser                         }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.UDDIHelper;

interface

function GetBindingkeyAccessPoint(const Operator: String; const key: String): String;

implementation

uses
  Soap.inquire_v1, Soap.SOAPHTTPClient;


function GetUDDIService(const Operator: String): InquireSOAP;
var
  HTTPRIO: THTTPRIO;
begin
  Result := nil;
  HTTPRIO := THTTPRIO.Create(nil);
  try
    Result := HTTPRIO as InquireSOAP;
    HTTPRIO.URL := Operator;
  finally
    if Result = nil then
      HTTPRIO.Free;
  end;
end;

function GetBindingkeyDetail(const Service: InquireSoap; const key: String): BindingDetail; overload;
var
  GBD: GetBindingDetail;
  BK: bindingKey;
begin
  GBD := GetBindingDetail.Create;
  try
    GBD.generic := '1.0';
    SetLength(BK, 1);
    BK[0] := key;
    GBD.bindingKey := BK;
    Result := Service.get_bindingDetail(GBD);
  finally
    GBD.Free;
  end;
end;

function GetBindingkeyDetail(const Operator: String; const key: String): BindingDetail; overload;
var
  Service: InquireSOAP;
begin
  Service := GetUDDIService(Operator);
  Result := GetBindingkeyDetail(Service, key);
end;

function GetBindingkeyAccessPoint(const Operator: String; const key: String): String;
var
  BD: BindingDetail;
begin
  BD := GetBindingkeyDetail(Operator, key);
  try
    if (BD.Len > 0) and Assigned(BD[0].accessPoint) then
      Result := BD[0].accessPoint.AccessPoint
    else
      Result := '';
  finally
    BD.Free;
  end;
end;


end.

