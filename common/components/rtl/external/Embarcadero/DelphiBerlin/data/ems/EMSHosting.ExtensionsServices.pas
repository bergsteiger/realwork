{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.ExtensionsServices;

{$HPPEMIT LINKUNIT}

interface

function AddService(const Handler: IUnknown): Integer;
procedure RemoveService(Index: Integer);

implementation

uses
  System.SysUtils, System.Generics.Collections,  System.Classes, EMS.Services,
  EMS.ResourceTypes, EMSHosting.Utility,
  System.JSON, EMS.ResourceApi, EMSHosting.ResourceManager, EMSHosting.Consts,
  EMSHosting.Endpoints;

var
  OTAExtensions: IInterfaceList;

type
  TEMSExtensionServices = class(TInterfacedObject, IInterface, IEMSServices,
    IEMSEndPointSegmentsService)
  public
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    { IEMSServices }
    function SupportsService(const Service: TGUID): Boolean;
    function GetService(const Service: TGUID): IInterface; overload;
    function TryGetService(const Service: TGUID; out Svc): Boolean; overload;
    { IEMSEndPointSegmentsService }
    procedure ExtractSegments(const AString: string; const AList: TEMSEndPointSegmentList);
    function CountSegments(const AValue: string): Integer;
  end;

procedure CreateServices;
begin
  if EMSServices = nil then
    EMSServices := TEMSExtensionServices.Create;
end;

function AddToList(const List: IInterfaceList; Item: IUnknown): Integer;
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do
    if List[I] = nil then
    begin
      List[I] := Item;
      Result := I;
      Exit;
    end;
  Result := List.Add(Item);
end;

function AddService(const Handler: IUnknown): Integer;
begin
  if OTAExtensions = nil then OTAExtensions := TInterfaceList.Create;
  Result := AddToList(OTAExtensions, Handler);
end;

procedure RemoveService(Index: Integer);
begin
  if OTAExtensions <> nil then
    OTAExtensions[Index] := nil;
end;

function TEMSExtensionServices.GetService(const Service: TGUID): IInterface;
begin
  if not Supports(Self, Service, Result) then
    Result := nil;
end;

function TEMSExtensionServices.CountSegments(const AValue: string): Integer;
var
  LTemp: TStrings;
begin
  if AValue.StartsWith('/') then
    LTemp := ParseURLPath(AValue.Substring(1))
  else
    LTemp := ParseURLPath(AValue);
  try
    Result := LTemp.Count;
  finally
    LTemp.Free;
  end;
end;

procedure TEMSExtensionServices.ExtractSegments(const AString: string;
  const AList: TEMSEndPointSegmentList);
var
  LName: string;
  LStrings: TStrings;
  S: string;
begin
  if AString.StartsWith('/') then
    LStrings := ParseURLPath(AString.Substring(1))
  else
    LStrings := ParseURLPath(AString);
  try
    for S in  LStrings do
    begin
      if S = '/' then
        TEMSEndPointSegmentSlash.Create(AList)
      else if S = '*' then
        TEMSEndPointSegmentWildcard.Create(AList)
      else if S.StartsWith('{') then
      begin
        if S.EndsWith('}') then
          LName := S.Substring(1, S.Length - 2)
        else if S.EndsWith('}/') then
          LName := S.Substring(1, S.Length - 3)
        else if S.EndsWith('/') then
          LName := S.Substring(1, S.Length-2)
        else
          LName := S.Substring(1, S.Length-1);
        TEMSEndPointSegmentParameter.Create(AList, LName);
      end
      else
        TEMSEndPointSegmentConstant.Create(AList, S);
    end;
  finally
    LStrings.Free;
  end;
end;

function TEMSExtensionServices.TryGetService(const Service: TGUID; out Svc): Boolean;
begin
  Result := Supports(Self, Service, Svc);
end;

function TEMSExtensionServices.SupportsService(const Service: TGUID): Boolean;
begin
  Result := Supports(Self, Service);
end;

function TEMSExtensionServices.QueryInterface(const IID: TGUID; out Obj): HResult;
var
  I: Integer;
  Item: IUnknown;
begin
  try
    if GetInterface(IID, Obj) then
    begin
      Result := S_OK;
      Exit;
    end else if OTAExtensions <> nil then
      for I := 0 to OTAExtensions.Count - 1 do
      begin
        Item := OTAExtensions[I];
        if Item <> nil then
        begin
          Result := Item.QueryInterface(IID, Obj);
          Item := nil;
          if Result = S_OK then Exit;
        end;
      end;
  except
    // in case something horribly bogus is passed in Obj, fail silently and return failure
    // this is fairly easy to do when talking to the OTA from C++
  end;
  Result := E_NOINTERFACE;
end;

initialization
  CreateServices;
finalization
  EMSServices := nil;
end.
