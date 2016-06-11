{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.ResourceManager;

interface

{$HPPEMIT LINKUNIT}
uses
  System.Generics.Collections, System.SysUtils,
   EMS.ResourceAPI;


type

  TEMSEndpointManagerImpl = class(TEMSEndpointManager)
  private
    FResources: TList<TEMSResource>;
    class procedure Init;
    class function GetInstance: TEMSEndpointManagerImpl; static;
  protected
    // Override
    function GetResources: TArray<TEMSResource>; override;
  public
    constructor Create;
    destructor Destroy; override;
    // Internal
    function FindByBaseURL(const ABaseURL: string): TArray<TEMSResource>;
    function FindByName(const AName: string): TEMSResource;
    // Override
    procedure RegisterResource(const AResource: TEMSResource); override;
    class property Instance: TEMSEndpointManagerImpl read GetInstance;
  end;

  TEMSEndpointAuthorizationImpl = class(TEMSEndpointAuthorization)
  public type
    TACL = TEMSEndpointAuthorization.TACL;
  private
    FACL: TDictionary<string, TACL>;
    FAllowCreator: TDictionary<string, Boolean>;
    class function GetInstance: TEMSEndpointAuthorizationImpl; static;
    class procedure Init;
  public
    constructor Create;
    destructor Destroy; override;
    // Internal
    procedure RegisterACL(const AName: string; const AACL: TACL);
    // Some endpoints are always allowed for the the creator of the resource item (e.g.; User)
    procedure RegisterAllowCreator(const AResourceName: string; const AEndpointNames: TArray<string>);
    function AllowCreator(const AName: string): Boolean;
    function AllowCreatorEndpoints(const AResource: string): TArray<string>;
    // Override
    procedure Authorize(const AContext: TEndpointContext; const AACL: TACL); override;
    function FindACL(const AName: string; out AACL: TACL): Boolean; override;
    class property Instance: TEMSEndpointAuthorizationImpl read GetInstance;
  end;


implementation

uses EMSHosting.Helpers, EMSHosting.Consts, System.Generics.Defaults;

{ TEMSEndpointManagerImpl }

constructor TEMSEndpointManagerImpl.Create;
begin
  FResources := TObjectList<TEMSResource>.Create;
end;

destructor TEMSEndpointManagerImpl.Destroy;
begin
  FResources.Free;
  inherited;
end;

function TEMSEndpointManagerImpl.FindByBaseURL(
  const ABaseURL: string): TArray<TEMSResource>;
var
  LList: TLIst<TEMSResource>;
  LEMSResource: TEMSResource;
begin
  LList := TList<TEMSResource>.Create;
  try
    for LEMSResource in FResources do
    begin
      if LEMSResource.IsBaseURL(ABaseURL) then
        LList.Add(LEMSResource);
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TEMSEndpointManagerImpl.FindByName(
  const AName: string): TEMSResource;
var
  LEMSResource: TEMSResource;
begin
  Result := nil;
  for LEMSResource in FResources do
    if SameText(LEMSResource.Name, AName) then
    begin
      if Result <> nil then
        raise Exception.Create('Duplicate');
      Result := LEMSResource;
    end;
end;

class function TEMSEndpointManagerImpl.GetInstance: TEMSEndpointManagerImpl;
begin
  Result := TEMSEndpointManager.Instance as TEMSEndpointManagerImpl;
end;

function TEMSEndpointManagerImpl.GetResources: TArray<TEMSResource>;
begin
  Result := FResources.ToArray;
end;

class procedure TEMSEndpointManagerImpl.Init;
begin
  TEMSEndpointManager.FEndpointManagerFactory :=
    function: TEMSEndpointManager
    begin
      Result := TEMSEndpointManagerImpl.Create;
    end;
end;

class procedure TEMSEndpointAuthorizationImpl.Init;
begin
  TEMSEndpointAuthorization.FEndpointAuthorizationFactory :=
    function: TEMSEndpointAuthorization
    begin
      Result := TEMSEndpointAuthorizationImpl.Create;
    end;
end;

procedure TEMSEndpointManagerImpl.RegisterResource(const AResource: TEMSResource);
begin
  TLogHelpers.LogRegisterResource(AResource);
  FResources.Add(AResource);

end;

procedure TEMSEndpointAuthorizationImpl.RegisterACL(const AName: string; const AACL: TACL);
begin
  FACL.AddOrSetValue(AName, AACL);
end;


procedure TEMSEndpointAuthorizationImpl.RegisterAllowCreator(const AResourceName: string;
  const AEndpointNames: TArray<string>);
var
  S: string;
begin
  // This should be called before we register ACL
  Assert(FACL.Count = 0);
  // Should be form of resource.endpoint
  for S in AEndpointNames do
    FAllowCreator.AddOrSetValue(AResourceName + '.' + S, True);
end;

{ TEMSEndpointAuthorizationImpl }

function TEMSEndpointAuthorizationImpl.AllowCreator(
  const AName: string): Boolean;
begin
  if not FAllowCreator.TryGetValue(AName, Result) then
    Result := False;
end;

function TEMSEndpointAuthorizationImpl.AllowCreatorEndpoints(
  const AResource: string): TArray<string>;
var
  LName: string;
  LNames: TList<string>;
  LCompare: string;
begin
  LCompare := AResource + '.';
  LNames := TList<string>.Create;
  try
    for LName in FAllowCreator.Keys do
    begin
      if LName.StartsWith(LCompare, True) then
        LNames.Add(LName);
    end;
    Result := LNames.ToArray;
  finally
    LNames.Free;
  end;
end;

procedure TEMSEndpointAuthorizationImpl.Authorize(
  const AContext: TEndpointContext; const AACL: TACL);
const
  sSampleID = '00000000-0000-0000-0000-000000000000';   // do not localize

  function IsUserID(const AValue: string): Boolean;
  begin
    Result := (Length(AValue) = Length(sSampleID)) and
       (AValue.IndexOf('-') = 8);
  end;

var
  S: string;
begin
  if TEndpointContext.TAuthenticate.MasterSecret in AContext.Authenticated then
    Exit; // OK

  if AACL.IsPublic then
    Exit; // OK

  if AContext.User = nil then
    AContext.Response.RaiseUnauthorized; // User not found

  Assert(IsUserID(sSampleID));
  for S in AACL.Users do
  begin
    if S = '*' then
      Exit // OK
    else if S = AContext.User.UserID then
    begin
      Assert(IsUserID(S));
      Exit // OK
    end
    else if (S = AContext.User.UserName) and not IsUserID(S) then
      Exit // OK
  end;

  for S in AACL.Groups do
  begin
    if S = '*' then
    begin
      if AContext.User.Groups.Count > 0 then
        Exit // OK
    end
    else if AContext.User.Groups.Contains(S) then
      Exit // OK
  end;

  if not AACL.AllowCreator then
    // If we get here then no group or user match
    AContext.Response.RaiseUnauthorized
  else
    // Authorize creator when execute method
    TEndpointHelpers.SetCreatorRequired(AContext);
end;

constructor TEMSEndpointAuthorizationImpl.Create;
begin
  FACL := TObjectDictionary<string, TACL>.Create([doOwnsValues], TIStringComparer.Ordinal);
  FAllowCreator := TDictionary<string, Boolean>.Create(TIStringComparer.Ordinal);
end;

destructor TEMSEndpointAuthorizationImpl.Destroy;
begin
  FACL.Free;
  FAllowCreator.Free;
  inherited;
end;

function TEMSEndpointAuthorizationImpl.FindACL(const AName: string;
  out AACL: TACL): Boolean;
begin
  Result := FACL.TryGetValue(AName, AACL);
end;

class function TEMSEndpointAuthorizationImpl.GetInstance: TEMSEndpointAuthorizationImpl;
begin
  Result := TEMSEndpointAuthorization.Instance as TEMSEndpointAuthorizationImpl;
end;

initialization
  TEMSEndpointManagerImpl.Init;
  TEMSEndpointAuthorizationImpl.Init;
end.
